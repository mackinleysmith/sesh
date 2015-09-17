require 'sesh'
require 'tmuxinator'
require 'optparse'
require 'yaml'
require 'colorize'
require 'open3'
require 'deep_merge'

module Sesh
  class Cli
    def self.start
      puts; puts "  Sesh v#{VERSION}".green; puts '  ==========='.green; puts
      if ARGV.empty? or ARGV.include? '-h' or ARGV.include? '--help'
        puts HELP_BANNER.blue; exit end
      parse_options!
      @tmux_control = TmuxControl.new @options[:project], @options[:tmux]
      @ssh_control  = SshControl.new @tmux_control, @options[:ssh]
      handle_command!
    end

    def self.parse_options!
      @command = ARGV.shift

      # Load config from a YAML file in the project root if available.
      @config_filepath = nil
      @config_friendly_filepath = nil
      POSSIBLE_CONFIG_LOCATIONS.each do |path|
        fullpath = File.join Dir.pwd, path
        next unless File.exists? fullpath
        @config_filepath  = fullpath
        @config_friendly_filepath = path
        break
      end
      @defaults = DEFAULT_OPTIONS.dup
      if @config_filepath.nil?
        @config_friendly_filepath = POSSIBLE_CONFIG_LOCATIONS[0]
      else
        loaded_config = deep_symbolize YAML::load_file(@config_filepath)
        @defaults.deep_merge! loaded_config
      end

      # Parse options given to the command.
      parsed_options = @defaults.dup
      OptionParser.new do |opts|
        opts.banner = HELP_BANNER

        opts.on("-p", "--project=project", 'Project') {|v|
          parsed_options[:project] = v }

        # Options for "new" command
        if @command == 'new'
          opts.on('-T', '--template=path', 'Path to Tmuxinator Template') {|v|
            parsed_options[:template] = v }
        end

        # Options for "connect" and "enslave" commands
        if %w(connect enslave).include? @command
          opts.on('-N', '--new-window', 'Connect in a new terminal window') {|v|
            parsed_options[:ssh][:connect_in_new_window] = true }
          opts.on('-F', '--fullscreen', 'Fullscreen new terminal window after connecting') {|v|
            parsed_options[:ssh][:connect_fullscreen] = true }
        end

        # SSH options
        opts.on("-L", "--local-ssh-addr=addr", 'Local SSH Address') {|v|
          parsed_options[:ssh][:local_addr] = v }
        opts.on("-R", "--remote-ssh-addr=addr", 'Remote SSH Address') {|v|
          parsed_options[:ssh][:remote_addr] = v }

        # Tmux options
        # opts.on('-S', '--tmux-socket-file=path', 'Path to Tmux Socket File') {|v|
        #   # fatal("Socket file #{v} does not exist.") unless File.exist?(v)
        #   parsed_options[:tmux][:socket_file] = v }
        # opts.on('--tmux-pids-file=path', 'Path to Tmux Pids File') {|v|
        #   parsed_options[:tmux][:pids_file] = v }

        # Shell options for remote commands
        opts.on('-C', '--shell-command=cmd', 'Shell Command to Execute') {|v|
          parsed_options[:shell][:command] = v }
        opts.on('-P', '--shell-pane=pane', 'Pane to Execute Shell Command in') {|v|
          parsed_options[:shell][:pane] = v }
        opts.on('--spec-path=path', 'Path to Spec File to Run') {|v|
          parsed_options[:shell][:spec] = v }

        # # target_opts = DEPLOYMENT_TARGETS.join '|'
        # opts.on("-T", "--target=target", 'Titanium Deployment Target') do |v|
        #   if DEPLOYMENT_TARGETS.include? v
        #     platform = parsed_options[:titanium_command][:platform]
        #     if v == 'xcode'
        #       parsed_options[:titanium_command][:run_with_xcode] = true
        #       v = 'simulator'
        #     end
        #     if v == 'emulator' && platform == 'ios' then v = 'simulator'
        #     elsif v == 'simulator' && platform == 'android' then v = 'emulator' end
        #     parsed_options[:titanium_command][:target] = v
        #   else fatal "Target \"#{v}\" not recognized." end
        # end
        #
        # opts.on('-O', '--output-dir=dir', 'Titanium Output Directory') {|v|
        #   parsed_options[:titanium_command][:output_dir] = v }
        #
        # opts.on('-L', '--log-level=level', 'Titanium Log Level') {|v|
        #   parsed_options[:titanium_command][:log_level] = v }
        #
        # opts.on('-V', '--developer-certificate=certificate',
        #         'iOS Developer Certificate') {|v|
        #   parsed_options[:ios_credentials][:development][:developer_certificate] = v
        #   parsed_options[:ios_credentials][:production][:developer_certificate] = v }
        # opts.on('-P', '--provisioning-profile=profile',
        #         'iOS Provisioning Profile') {|v|
        #   parsed_options[:ios_credentials][:development][:provisioning_profile] = v
        #   parsed_options[:ios_credentials][:production][:provisioning_profile] = v }
        #
        # opts.on('-U', '--simulator-udid=udid', 'iOS Simulator UDID') {|v|
        #   parsed_options[:ios_simulator][:udid] = v }
        # opts.on('-D', '--devicetypeid=dtid', 'iOS Simulator DeviceTypeID') {|v|
        #   parsed_options[:ios_simulator][:devicetypeid] = v }
        #
        # opts.on('--no-autofocus', 'Disable iOS Simulator Autofocus') {
        #   parsed_options[:ios_simulator][:autofocus] = false }

        opts.on('--help', 'Prints this help') { puts opts.banner; exit }
      end.parse!
      @options = parsed_options
      if @options[:project].nil?
        project_required = !%w(new list).include?(@command)
        ARGV.each {|a|
          if Tmuxinator::Config.exists? a
            @options[:project] = ARGV.delete a
            break end } if project_required && ARGV.any?
        @options[:project] ||= Inferences.infer_project_from_current_directory
        if project_required && @options[:project].nil?
          Logger.warn 'A matching Sesh project could not be found.'
          Logger.fatal 'Hint: run sesh new or specify an existing project with your commmand.'
        end
      end
      if %w(new).include? @command
        @options[:project]  ||= Inferences.infer_current_directory
        @options[:template] ||= File.join(
          File.dirname(File.expand_path(__FILE__)), 'assets', 'sample.yml' )
      end
      # @options[:tmux][:socket_file] ||= "/tmp/#{@options[:project]}.sock"
      # @options[:tmux][:pids_file]   ||= "/tmp/#{@options[:project]}.pids.txt"
      if %w(enslave connect).include? @command
        @options[:ssh][:local_addr] ||= Sesh::Inferences.infer_local_ssh_addr
        if @options[:ssh][:remote_addr].nil? && ARGV.any?
          ARGV.each {|a|
            if a =~ /\.local$/ || a =~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ || a =~ /^(.+)@(.+)$/
              @options[:ssh][:remote_addr] = a
              break end }
          @options[:ssh][:remote_addr] ||= ARGV.shift
        end
        if @options[:ssh][:remote_addr].nil?
          if %w(enslave).include? @command
            Logger.warn 'A remote address is required.'
            Logger.fatal 'Hint: specify a remote ssh address using the -R flag.'
          elsif %w(connect).include? @command
            @options[:ssh][:remote_addr] = Inferences.infer_local_ssh_addr
          end
        end
      end
      # TODO: parse a spec file
      # This block should always go at the end because it eats the rest of ARGV.
      if %w(run).include?(@command) && @options[:shell][:command].nil?
        if ARGV.any?
          argv_cmd_parts = []
          argv_cmd_parts << ARGV.shift while ARGV.any?
          @options[:shell][:command] = argv_cmd_parts.join(' ')
        end
        if @options[:shell][:command].nil? || @options[:shell][:command].length == 0
          Logger.fatal 'You must specify a command to run.'
        end
      end
    end

    def self.handle_command!
      if @command
        case @command
        when 'start'   then @tmux_control.start_project!
        when 'stop'    then @tmux_control.stop_project!
        when 'restart' then @tmux_control.restart_project!
        when 'new'
          config = Tmuxinator::Config.project @options[:project]
          unless Tmuxinator::Config.exists?(@options[:project])
            erb = Erubis::Eruby.new(File.read(@options[:template])).result binding
            File.open(config, 'w') { |f| f.write(erb) }
          end

          Kernel.system("#{Inferences.infer_default_editor} #{config}") ||
                           Tmuxinator::Cli.new.doctor
          puts
        when 'edit'
          config = Tmuxinator::Config.project(@options[:project])
          if Tmuxinator::Config.exists? @options[:project]
            Kernel.system("#{Inferences.infer_default_editor} #{config}") ||
                           Tmuxinator::Cli.new.doctor
            puts
          else
            Logger.fatal "Sesh project '#{@options[:project]}' does not exist yet!"
          end
        when 'list'
          running_projects = TmuxControl.get_running_projects
          pcount = running_projects.count
          if pcount > 0
            Logger.success "#{pcount} project#{pcount>1 ? 's':''} currently running:"
            running_projects.each do |rp|
              puts; Logger.info "Project: #{rp}", 1
              tc = TmuxControl.new rp
              tc_clients = tc.connected_client_devices
              if tc_clients.any?
                Logger.success "Connected Client Devices:", 2
                tc_clients.each_with_index do |c, i|
                  Logger.info "#{i+1}: #{c}: #{tc.get_ip_from_device(c)}", 3
                end
              else
                Logger.warn 'No clients connected.', 2
              end
            end
            puts
          else Logger.fatal "There are no Sesh projects currently running." end
        when 'connect'
          if @options[:ssh][:local_addr] == @options[:ssh][:remote_addr]
            unless @tmux_control.already_running?
              Logger.fatal "Sesh project '#{@options[:project]}' is not running!"
            end
          end
          system @ssh_control.enter_slave_mode_command
        when 'enslave'
          Logger.fatal("Sesh project '#{@options[:project]}' is not running!") unless @tmux_control.already_running?
          Logger.fatal("You must specify a machine to enslave! Eg: user@ip") if @options[:ssh][:remote_addr].nil?
          Logger.info "Attempting to connect #{@options[:ssh][:remote_addr]} to Sesh project '#{@options[:project]}'..."
          if @ssh_control.enslave_peer!
            Logger.success "Sesh client connected successfully."
          else Logger.fatal 'Sesh client failed to connect.' end
        when 'begin' then @tmux_control.begin_tmuxinator_session!
        when 'run'
          @tmux_control.do_shell_operation! @options[:shell]
        when 'rspec'
          puts "Spec: #{@options[:shell][:spec]}"
        when 'detach' then @tmux_control.disconnect_client! ARGV.join(' ')
        else
          Logger.fatal "Command not recognized!"
        end
        exit 0
      end

      Logger.fatal 'You must specify a command.'
    end
  end
end

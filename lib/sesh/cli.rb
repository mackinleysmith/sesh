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

      if @command
        case @command
        when 'start'
          if @tmux_control.already_running?
            Logger.fatal "Sesh project '#{@options[:project]}' is already running!"
          else
            Logger.info "Starting Sesh project '#{@options[:project]}'..."
          end
          @tmux_control.kill_running_processes
          if @tmux_control.issue_start_command! &&
             Logger.show_progress_until(-> { @tmux_control.already_running? })
            sleep 1
            if @tmux_control.already_running?
              @tmux_control.store_pids_from_session!
              Logger.success 'Sesh started successfully.'
              puts
            else Logger.fatal 'Sesh failed to start!' end
          else Logger.fatal 'Sesh failed to start after ten seconds!' end
        when 'stop'
          if @tmux_control.already_running?
            Logger.info "Stopping Sesh project '#{@options[:project]}'..."
          else
            Logger.fatal "Sesh project '#{@options[:project]}' is not running!"
          end
          @tmux_control.kill_running_processes
          @tmux_control.issue_stop_command!
          if $? && Logger.show_progress_until(-> { !@tmux_control.already_running? })
            Logger.success 'Sesh stopped successfully.'
            puts
          else
            Logger.fatal 'Sesh failed to stop after ten seconds!'
          end
        when 'restart'
          Logger.fatal("Sesh project '#{@options[:project]}' is not running!") unless already_running?
          puts `sesh stop #{@options[:project]} #{@options if @options.any?}`.strip
          sleep 0.5
          puts `sesh start #{@options[:project]} #{@options if @options.any?}`.strip
        when 'new'
          config = Tmuxinator::Config.project(@options[:project])
          unless Tmuxinator::Config.exists?(@options[:project])
            template = File.join(File.dirname(File.expand_path(__FILE__)),
                                 "../lib/sesh/assets/sample.yml")
            erb  = Erubis::Eruby.new(File.read(template)).result(binding)
            File.open(config, "w") { |f| f.write(erb) }
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
          output = Sesh.format_and_run_command <<-BASH
            ps aux | grep tmux | grep "sesh begin" | grep -v "[g]rep" \
                   | sed -e "s/.*\\/tmp\\/\\(.*\\)\\.sock.*/\\1/"
          BASH
          running_projects = output.split("\n")
          pcount = running_projects.count
          if pcount > 0
            Logger.success "#{pcount} project#{pcount>1 ? 's':''} currently running:"
            puts; running_projects.each {|rp| Logger.info rp, 1 }
            puts
          else
            Logger.fatal "There are no Sesh projects currently running."
          end
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
          else
            Logger.fatal 'Sesh client failed to start.'
          end
        when 'begin' then @tmux_control.begin_tmuxinator_session!
        when 'run'
          unless ARGV.any?
            Logger.fatal 'A second command is required!'
          end
          @shell_command = ARGV.join(' ')
          puts "Subcommand: #{@shell_command}"
        when 'rspec'
          unless ARGV.any?
            Logger.fatal 'A path to a spec is required!'
          end
          @shell_command = ARGV.join(' ')
          puts "Spec: #{@shell_command}"
        else
          Logger.fatal "Command not recognized!"
        end
        exit 0
      end

      Logger.fatal 'You must specify a command.'
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

        opts.on("-L", "--local-ssh-addr=addr", 'Local SSH Address') {|v|
          parsed_options[:ssh][:local_addr] = v }
        opts.on("-R", "--remote-ssh-addr=addr", 'Remote SSH Address') {|v|
          parsed_options[:ssh][:remote_addr] = v }

        opts.on('-S', '--tmux-socket-file=path', 'Path to Tmux Socket File') {|v|
          # fatal("Socket file #{v} does not exist.") unless File.exist?(v)
          parsed_options[:tmux][:socket_file] = v }
        opts.on('-P', '--tmux-pids-file=path', 'Path to Tmux Pids File') {|v|
          parsed_options[:tmux][:pids_file] = v }

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
      @options[:tmux][:socket_file] ||= "/tmp/#{@options[:project]}.sock"
      @options[:tmux][:pids_file]   ||= "/tmp/#{@options[:project]}.pids.txt"
      @options[:ssh][:local_addr]   ||= Sesh::Inferences.infer_local_ssh_addr
      if @options[:ssh][:remote_addr].nil?
        if ARGV.any?
          ARGV.each {|a|
            if a =~ /\.local$/ || a =~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ || a =~ /^(.+)@(.+)$/
              @options[:ssh][:remote_addr] = a
              break end }
          @options[:ssh][:remote_addr] ||= ARGV.shift
        end
        if @options[:ssh][:remote_addr].nil?
          if %w(enslave run rspec).include? @command
            Logger.warn 'A remote address is required.'
            Logger.fatal 'Hint: specify a remote ssh address using the -R flag.'
          elsif %w(connect).include? @command
            @options[:ssh][:remote_addr] = Inferences.infer_local_ssh_addr
          end
        end
      end
    end
  end
end

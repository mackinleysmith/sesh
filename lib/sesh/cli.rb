require 'sesh'
require 'tmuxinator'
require 'optparse'
require 'yaml'
require 'colorize'
require 'open3'
require 'deep_merge'

module Sesh
  class Cli
    DEFAULT_OPTIONS = {
      project: nil,
      ssh: {
        local_addr: nil,
        remote_addr: nil
      },
      tmux: {
        socket_file: nil,
        pids_file: nil
      }
    }
    POSSIBLE_CONFIG_LOCATIONS = %w( sesh_config.yml config/sesh.yml )

    def self.start
      puts
      puts "Sesh v#{Sesh::VERSION}".green
      puts "======================".green
      puts

      help_banner = <<-HELP
      Sesh: remote background sessions powered by tmux and tmuxinator.
      Runs a headless tmuxinator session for remote slave machines to connect to.

      Usage: #{File.basename $0} command [project]

      Commands:

      sesh new                           Create a new tmuxinator configuration.
      sesh edit    [project]             Edit an existing tmuxinator configuration.
      sesh start   [project]             Start a Sesh session for a project.
      sesh stop    [project]             Stop a Sesh session for a project.
      sesh list                          List running Sesh sessions on this machine.
      sesh enslave [project] user@host   Connect a slave to a local Sesh session.
      sesh connect [project] [user@host] Connect as a slave to a Sesh session.
      sesh run     [location] [command]  Run a shell command in the specified location.
      sesh rspec   [location] [spec]     Run a spec in the specified location.

      Leave project blank to use the name of your current directory.

      HELP
      if ARGV.empty? or ARGV.include? '-h' or ARGV.include? '--help'
        puts help_banner.blue
        exit
      end

      @command = ARGV.shift

      #
      # Logging Methods
      #

      #
      # Helper methods
      #

      #
      # Option parsing
      #


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
        opts.banner = help_banner

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
        # opts.on('--skip-compile', 'Skip Source Compilation') {
        #   parsed_options[:skip_compile] = true }
        # opts.on('--skip-build', 'Skip Titanium Build') {
        #   parsed_options[:skip_build] = true }

        opts.on('--help', 'Prints this help') do
          puts opts.banner
          exit
        end
      end.parse!
      @options = parsed_options
      if @options[:project].nil?
        project_required = !%w(new list).include?(@command)
        ARGV.each {|a|
          if Tmuxinator::Config.exists? a
            @options[:project] = ARGV.delete a
            break end } if project_required && ARGV.any?
        @options[:project] ||= Sesh::Inferences.infer_project_from_current_directory
        if project_required && @options[:project].nil?
          Logger.warn 'A matching Sesh project could not be found.'
          Logger.fatal 'Hint: run sesh new or specify an existing project with your commmand.'
        end
      end
      @options[:tmux][:socket_file] ||= "/tmp/#{@options[:project]}.sock"
      @options[:tmux][:pids_file]   ||= "/tmp/#{@options[:project]}.pids.txt"
      @options[:ssh][:local_addr]   ||= Sesh::Inferences.infer_local_ssh_addr
      if @options[:ssh][:remote_addr].nil?
        ARGV.each {|a|
          if a =~ /\.local$/ || a =~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ || a =~ /^(.+)@(.+)$/
            @options[:ssh][:remote_addr] = a
            break end } if ARGV.any?
        if @options[:ssh][:remote_addr].nil?
          if %w(enslave run rspec).include? @command
            Logger.warn 'A remote address is required.'
            Logger.fatal 'Hint: specify a remote ssh address using the -R flag.'
          elsif %w(connect).include? @command
            @options[:ssh][:remote_addr] = Sesh::Inferences.infer_local_ssh_addr
          end
        end
      end
      Logger.info @options[:ssh][:local_addr]
      exit

      def project_name_matcher
        pn = @options[:project].gsub '-', '\-'
        "[t]mux.*[#{pn[0]}]#{pn[1..-1]}"
      end

      def already_running?
        output = `ps aux | grep "#{project_name_matcher}"`.strip
        output.length > 0
      end

      def format_command(command) command.gsub(/\ [ ]+/, ' ').strip end
      def format_and_run_command(command) `#{format_command(command)}`.strip end

      def issue_server_start_command!
        `tmux -S "#{@socket_file}" new-session -d "env TMUX='' mux start #{@options[:project]}"`
      end

      def issue_server_stop_command!
        `pkill -f "#{project_name_matcher}"`
      end

      def connection_command(local=false, addr=nil)
        addr ||= @local_ssh_addr
        local_command = "tmux -S #{@socket_file} a"
        return local_command if local
        "ssh #{addr} -t '#{local_command}'"
      end

      def enter_slave_mode_command(local=false, addr=nil)
        @term_app ||= get_term_app
        case @term_app
        when 'iTerm'
          tell_term_app     = 'tell application "' + @term_app + '"'
          tell_term_process = 'tell application "System Events" to tell process "' + 
                               @term_app + '"'
          format_command <<-BASH
            osascript \
                  -e '#{tell_term_app} to activate' \
                  -e '#{tell_term_process} to keystroke \"n\" using command down' \
                  -e 'delay 1' \
                  -e "#{tell_term_app.gsub('"', '\\"')} to tell session -1 of current \
                      terminal to write text \\"#{connection_command(local, addr)}\\"" \
                  -e '#{tell_term_process} to keystroke return using command down'
          BASH
        when 'Terminal'
          format_command connection_command(local, addr)
        end
      end

      def show_progress_until(condition_lambda, timeout=10)
        started_progress_at = Time.now
        return true if condition_lambda.call
        print '> '
        until condition_lambda.call or Time.now - started_progress_at > timeout
          print '.'
          $stdout.flush
          sleep 0.5 
        end
        puts
        return condition_lambda.call
      end

      def kill_running_processes
        if File.exists? @pids_file
          File.readlines(@pids_file).each{|pid| kill_process! pid }
          File.delete @pids_file
        end
      end
      def kill_process!(pid)
        `kill -9 #{pid}`
      end

      if @command
        case @command
        when 'start'
          fatal("Sesh project '#{@options[:project]}' is already running!") if already_running?
          debug "Starting Sesh project '#{@options[:project]}'..."
          kill_running_processes
          output = issue_server_start_command!
          success = show_progress_until ->{ already_running? }
          if success
            sleep 1
            if $? && already_running?
              pids = `tmux list-panes -s -F "\#{pane_pid} \#{pane_current_command}" | grep -v tmux | awk '{print $1}'`.strip.lines
              File.open(@pids_file, 'w') {|f| pids.each{|pid| f.puts pid } }
              debug 'Sesh started successfully.'
              debug "To connect: #{connection_command}"
              # TODO: show other sesh commands (connect, enslave), specify full
              #       command as what is needed for machines without sesh.
              puts
            else
              fatal 'Sesh failed to start!'
            end
          else
            fatal 'Sesh failed to start after ten seconds!'
          end
        when 'stop'
          fatal("Sesh project '#{@options[:project]}' is not running!") unless already_running?
          debug "Stopping Sesh project '#{@options[:project]}'..."
          kill_running_processes
          output = issue_server_stop_command!
          success = show_progress_until ->{ !already_running? }
          if success && $?
            debug 'Sesh stopped successfully.'
            puts
          else
            fatal 'Sesh failed to stop after ten seconds!'
          end
        when 'restart'
          fatal("Sesh project '#{@options[:project]}' is not running!") unless already_running?
          puts `sesh stop #{@options[:project]} #{@options if @options.any?}`.strip
          sleep(0.5)
          puts `sesh start #{@options[:project]} #{@options if @options.any?}`.strip
        when 'new'
          name = @options[:project]
          config = Tmuxinator::Config.project(name)

          unless Tmuxinator::Config.exists?(name)
            template = File.join(File.dirname(File.expand_path(__FILE__)), "../lib/sesh/assets/sample.yml")
            erb  = Erubis::Eruby.new(File.read(template)).result(binding)
            File.open(config, "w") { |f| f.write(erb) }
          end

          Kernel.system("#{get_editor} #{config}") || Tmuxinator::Cli.new.doctor
          puts
        when 'edit'
          config = Tmuxinator::Config.project(@options[:project])
          if Tmuxinator::Config.exists? @options[:project]
            Kernel.system("#{get_editor} #{config}") || Tmuxinator::Cli.new.doctor
            puts
          else
            fatal "Sesh project '#{@options[:project]}' does not exist yet!"
          end
        when 'list'
          output = format_and_run_command <<-BASH
            ps aux | grep tmux | grep "env TMUX='' mux start" \
                   | grep -v "[g]rep" | sed -e "s/.*mux start \\(.*\\)/\\1/"
          BASH
          running_projects = output.split("\n")
          pcount = running_projects.count
          if pcount > 0
            puts "#{pcount} project#{pcount>1 ? 's':''} currently running:"
            puts running_projects
            puts
          else
            fatal "There are no Sesh projects currently running."
          end
        when 'connect'
          addr = @remote_address
          if (is_local=@remote_address.nil?)
            addr = @local_ssh_addr
            fatal("Sesh project '#{@options[:project]}' is not running!") unless already_running?
          end
          command = enter_slave_mode_command(is_local, addr)
          puts `#{command}`.strip
        when 'enslave'
          fatal("Sesh project '#{@options[:project]}' is not running!") unless already_running?
          fatal("You must specify a machine to enslave! Eg: user@ip") if @remote_address.nil?
          debug "Attempting to connect #{@remote_address} to Sesh project '#{@options[:project]}'..."
          output = format_and_run_command <<-BASH
            ssh #{@remote_address} "sesh connect #{@options[:project]} #{@local_ssh_addr}" 
          BASH
          puts output
          if $?
            debug "Sesh client connected successfully."
            puts
          else
            fatal 'Sesh client failed to start.'
          end
        when 'run'
          unless ARGV.any?
            fatal 'A second command is required!'
          end
          @shell_command = ARGV.join(' ')
          puts "Subcommand: #{@shell_command}"
        when 'rspec'
          unless ARGV.any?
            fatal 'A path to a spec is required!'
          end
          @shell_command = ARGV.join(' ')
          puts "Spec: #{@shell_command}"
        else
          fatal "Command not recognized!"
        end
        exit 0
      end

      fatal 'You must specify a command.'
    end
  end
end

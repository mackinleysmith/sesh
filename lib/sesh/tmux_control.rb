require 'sesh'

module Sesh
  class TmuxControl
    def initialize(project, options={})
      @project = project || Inferences::infer_project_from_current_directory
      @options = DEFAULT_OPTIONS[:tmux].merge(options)
    end

    def self.get_running_projects
      output = Sesh.format_and_run_command <<-BASH
        ps aux | grep tmux | grep "sesh begin" | grep -v "[g]rep" \
               | sed -e "s/.*\\/tmp\\/\\(.*\\)\\.sock.*/\\1/"
      BASH
      output.split("\n")
    end
    def already_running?; self.class.get_running_projects.include? @project end
      # `ps aux | grep "#{project_name_matcher}"`.strip.length > 0 end

    def project_name_matcher
      "[t]mux.*[t]mp\\/#{Regexp.escape(@options[:socket_file].split('/')[2..-1].join('/'))}.*"
    end
      # pn = @project.gsub '-', '\-'
      # "[t]mux.*[#{pn[0]}]#{pn[1..-1]}" end

    def issue_start_command!
      # Add bundle exec to the sesh begin command for dev purposes.
      cmd = Sesh.format_command <<-BASH
      tmux -S "#{@options[:socket_file]}" new-session -d "eval \\"\$SHELL -l -c 'rvm use default; sesh begin'\\"" 2>&1
      BASH
      output = `#{cmd}`.strip
      return true if $? && output.length == 0
      Logger.warn "Tmux failed to start with the following error: #{output}"; false
    end

    def issue_stop_command!; `pkill -f "#{project_name_matcher}"` end

    def connection_command; "tmux -S #{@options[:socket_file]} a" end

    def obtain_pids_from_session
      `tmux -S "#{@options[:socket_file]}" list-panes -s -F "\#{pane_pid} \#{pane_current_command}" | grep -v tmux | awk '{print $1}'`.strip.lines
    end
    def store_pids_from_session!
      File.open(@options[:pids_file], 'w') {|f|
        obtain_pids_from_session.each{|pid| f.puts pid } }
    end

    def kill_running_processes
      if File.exists? @options[:pids_file]
        File.readlines(@options[:pids_file]).each{|pid| kill_process! pid }
        File.delete @options[:pids_file]
      end
    end
    def kill_process!(pid); `kill -9 #{pid}` end

    def begin_tmuxinator_session!
      %x[env TMUX='' mux start #{@project}] end

    def start_project!
      if already_running?
        Logger.fatal "Sesh project '#{@project}' is already running!" end
      Logger.info "Starting Sesh project '#{@project}'..."
      kill_running_processes
      if issue_start_command! && Logger.show_progress_until(-> { already_running? })
        sleep 1
        if already_running?
          store_pids_from_session!
          Logger.success 'Sesh started successfully.'
          puts
        else Logger.fatal 'Sesh failed to start!' end
      else Logger.fatal 'Sesh failed to start after ten seconds!' end
    end
    def stop_project!
      unless already_running?
        Logger.fatal "Sesh project '#{@project}' is not running!" end
      Logger.info "Stopping Sesh project '#{@project}'..."
      kill_running_processes
      if issue_stop_command! && Logger.show_progress_until(-> { !already_running? })
        Logger.success 'Sesh stopped successfully.'
        puts
      else Logger.fatal 'Sesh failed to stop after ten seconds!' end
    end
    def restart_project!; stop_project!; sleep 0.5; start_project! end

    def send_keys_to_project!(keys)
      `tmux -S "#{@options[:socket_file]}" send-keys #{keys}`.strip.length == 0
    end
    def send_interrupt!; send_keys_to_project! 'C-c' end
    def interrupt_and_send_keys_to_project!(keys)
      send_interrupt!; send_keys_to_project! keys end
    def send_keys_to_pane!(pane, keys)
      move_cursor_to_pane! pane
      send_keys_to_project! keys end
    def interrupt_and_send_keys_to_pane!(pane, keys)
      move_cursor_to_pane_and_interrupt! pane
      send_keys_to_project! keys end
    def send_command_to_project!(command)
      send_keys_to_project! "\"#{command}\" Enter" end 
    def interrupt_and_send_command_to_project!(command)
      send_interrupt!; send_command_to_project!(command) end
    def send_command_to_pane!(pane, command)
      send_keys_to_pane! pane, "\"#{command}\" Enter" end
    def interrupt_and_send_command_to_pane!(pane, command)
      interrupt_and_send_keys_to_pane!(pane, "\"#{command}\" Enter") end
    def move_cursor_to_pane!(pane); send_keys_to_project! "C-a q #{pane}" end
    def move_cursor_to_pane_and_interrupt!(pane)
      move_cursor_to_pane!(pane); send_interrupt! end
    def do_shell_operation!(options=DEFAULT_OPTIONS[:shell])
      unless options[:spec].nil?
        options[:command] ||= "spring rspec #{options[:spec]}" end
      if options[:pane].nil?
        interrupt_and_send_command_to_project! options[:command]
      else
        interrupt_and_send_command_to_pane! options[:pane], options[:command]
      end
    end

    # Getter methods for passthru to SshControl class
    def project; @project end
    def options; @options end

  end
end

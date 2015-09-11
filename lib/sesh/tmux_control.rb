require 'sesh'

module Sesh
  class TmuxControl
    def initialize(project_name, options={})
      @project = project || Inferences::infer_project_from_current_directory
      @options = DEFAULT_OPTIONS[:tmux].merge(options)
    end

    def already_running?
      `ps aux | grep "#{project_name_matcher}"`.strip.length > 0 end

    def project_name_matcher
      pn = @project.gsub '-', '\-'
      "[t]mux.*[#{pn[0]}]#{pn[1..-1]}" end

    def issue_start_command!
      cmd = Sesh.format_command <<-BASH
      tmux -S "#{@options[:socket_file]}" new-session -d "eval \\"\$SHELL -l -c 'rvm use default; bundle exec sesh begin'\\"" 2>&1
      BASH
      # puts cmd
      output = `#{cmd}`.strip
      return true if $? && output.length == 0
      Logger.warn "Tmux failed to start with the following error: #{output}"; false
    end

    def issue_stop_command!; `pkill -f "#{project_name_matcher}"` end

    def connection_command; "tmux -S #{@options[:socket_file]} a" end

    def obtain_pids_from_session
      # TODO: grep this to just those pids from the current project
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

    # Getter methods for passthru to SshControl class
    def project; @project end
    def options; @options end

  end
end

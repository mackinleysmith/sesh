require 'sesh'
require 'pty'
require 'open4'
# require 'tmuxinator'
# require 'yaml'

module Sesh
  class TmuxControl
    def initialize(project, options={})
      @project = project || Inferences::infer_project_from_current_directory
      @options = {}.merge(DEFAULT_OPTIONS[:tmux]).merge options
      @socket_file = @options[:socket_file] || "/tmp/#{@project}.sock"
    end

    def self.get_running_projects
      output = Sesh.format_and_run_command <<-BASH
        ps aux | grep tmux | grep "sesh begin" | grep -v "[g]rep" \
               | sed -e "s/.*\\/tmp\\/\\(.*\\)\\.sock.*/\\1/"
      BASH
      output.lines.map(&:strip)
    end
    def already_running?; self.class.get_running_projects.include? @project end
      # `ps aux | grep "#{project_name_matcher}"`.strip.length > 0 end

    def project_name_matcher
      "[t]mux.*#{Regexp.escape(@project)}.*"
    end
      # pn = @project.gsub '-', '\-'
      # "[t]mux.*[#{pn[0]}]#{pn[1..-1]}" end

    def issue_start_command!
      # Add bundle exec to the sesh begin command for dev purposes.
      cmd = Sesh.format_command <<-BASH
      tmux -S "#{@socket_file}" new-session -d "eval \\"\$SHELL -l -c 'rvm use default; sesh begin #{@project}'\\"" 2>&1
      BASH
      output = `#{cmd}`.strip
      return true if $? && output.length == 0
      Logger.warn "Tmux failed to start with the following error: #{output}"; false
    end

    def issue_stop_command!
      # puts 'issuing stop command...'
      output = `ps -ef | grep "[t]mux -u attach-session -t #{Regexp.escape(@project)}\\$" | grep -v grep | awk '{print $2}' | xargs kill -9`
      puts "stop command issued! Output: #{output}"
      output
    end

    def connection_command; "tmux -S #{@socket_file} a" end

    def obtain_pids_from_session
      tmux_processes =
        `tmux list-panes -s -F "\#{pane_pid} \#{pane_current_command}" -t "#{@project}" 2> /dev/null | grep -v tmux | awk '{print $1}'`.strip.lines.map(&:strip) +
        `tmux -S "#{@socket_file}" list-panes -s -F "\#{pane_pid} \#{pane_current_command}" 2> /dev/null | grep -v tmux | awk '{print $1}'`.strip.lines.map(&:strip)
      tmux_processes.delete_if {|pid| `ps aux | grep #{pid} | grep -v grep | grep -v "sesh begin #{@project}"`.strip.length == 0 }
      puts; puts "Tmux Processes:"
      tmux_processes.each{|pid| puts `ps aux | grep #{pid} | grep -v grep`.strip }
      return [] unless tmux_processes.any?
      spring_processes = []; other_processes = []
      spring_app_pid = `ps -ef | grep "[s]pring app .*| #{@project} |" | grep -v grep | awk '{print $2}'`.strip
      spring_processes += `ps -ef | grep #{spring_app_pid} | grep -v grep | grep -v "[s]pring app" | awk '{print $2}'`.strip.lines.map(&:strip) if spring_app_pid.length > 0
      spring_processes += `ps -ef | grep "[s]pring.*| #{@project} |" | grep -v grep | awk '{print $2}'`.strip.lines.map(&:strip)
      puts; puts 'Spring Processes:'
      spring_processes.each{|pid| puts `ps aux | grep #{pid} | grep -v grep`.strip }
      tmux_processes.each{|pid|
        other_processes += obtain_child_pids_from_pid(pid) - tmux_processes }
      puts; puts 'Other Processes:'
      other_processes.each{|pid| puts `ps aux | grep #{pid} | grep -v grep`.strip }
      spring_processes + other_processes + tmux_processes
    end
    def obtain_child_pids_from_pid(pid)
      output = `ps -ef | grep #{pid} | grep -v grep | grep -v "sesh begin #{@project}" | awk '{print $2}'`.strip.lines.map(&:strip)
      output -= [pid]
      output += output.map{|cpid| obtain_child_pids_from_pid(cpid) - [pid] }.flatten
      output.reverse
    end

    def list_running_processes
      obtain_pids_from_session.each{|pid|
        puts `ps aux | grep #{pid} | grep -v grep`.strip }
    end
    def kill_running_processes
      pane_count = `tmux list-panes -s -F "\#{pane_pid} \#{pane_current_command}" -t "#{@project}" 2>/dev/null`.strip.lines.count
      pane_count.times{|i| move_cursor_to_pane_and_interrupt! i; sleep 0.1 }
      sleep 0.5; puts 'Killing pids from session...'
      obtain_pids_from_session.each{|pid|
        puts `ps aux | grep #{pid} | grep -v grep`.strip
        kill_process! pid }
      puts 'All pids from session have been killed.'
      # if File.exists? @options[:pids_file]
      #   File.readlines(@options[:pids_file]).each{|pid|
      #     puts "Killing #{pid}"
      #     kill_process! pid }
      #   File.delete @options[:pids_file]
      # end
    end
    def kill_process!(pid); `kill -9 #{pid} 2>&1` end

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

    def connected_client_devices
      `tmux -S "#{@socket_file}" list-clients 2>/dev/null | cut -d : -f 1 | cut -d / -f 3`.strip.lines.map(&:strip)
    end
    def get_ip_from_device(devname)
      ip_line = `who -a 2> /dev/null | grep " #{devname} "`.strip
      return '127.0.0.1' unless ip_line.length > 0 && ip_line =~ /\)$/
      ip_line.split('(')[-1][0..-2]
    end
    def get_device_from_ip(ip)
      return if ( connected_devs = connected_client_devices ).length == 0
      return connected_devs.find{|d| get_ip_from_device(ip) == ip } if ip == '127.0.0.1'
      who_lines = `who -a 2> /dev/null | grep "#{ Regexp.escape("(#{ip})") }"`.strip.lines
      puts connected_devs.inspect
      return if who_lines.length == 0
      connected_devs.find{|d| who_lines.find{|l| l =~ / #{d} / } }
    end
    def connected_clients
      connected_client_devices.map{|devname| get_ip_from_device(devname) } end
    def disconnect_client_by_device!(devname)
      `tmux -S "#{@socket_file}" detach-client -t "/dev/#{devname}"`.strip.length == 0 end
    def disconnect_client_by_ip!(ip)
      device = get_device_from_ip(ip)
      Logger.fatal("#{ip} is not connected to project \"#{@project}\".") if device.nil?
      disconnect_client_by_device! device end
    def disconnect_client_by_index!(index)
      disconnect_client_by_device! connected_client_devices[index] end
    def disconnect_client!(identifier)
      identifier = '127.0.0.1' if identifier.nil? || identifier.length == 0
      if identifier.to_i.to_s == identifier.to_s # It's an integer
        disconnect_client_by_index! identifier.to_i - 1
      elsif identifier =~ /[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+/ # It's an ip
        disconnect_client_by_ip! identifier
      elsif identifier =~ /.*@.*/ || identifier =~ /\.local$/
        ping_output = `ping -a -c 1 #{identifier} 2>&1`.strip.lines
        if $? && ping_output.length > 1 && ping_output[1] =~ / from /
          resolved_ip = ping_output[1].split(' from ')[1].split(': ')[0]
          disconnect_client_by_ip! resolved_ip
        else
          puts "Ping output: #{ping_output}"
        end
      else
        ssh_identifier =
          `awk '/Host #{identifier}/ {getline; print $2}' ~/.ssh/config`.strip
        return disconnect_client!(ssh_identifier) if ssh_identifier.length > 0
        fatal("Client")
      end
    end

    def send_keys_to_project!(keys)
      `tmux -S "#{@socket_file}" send-keys #{keys}`.strip.length == 0
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
        rspec_cmd = if options[:rspec_prefix].nil? then 'rspec'
                    else "#{options[:rspec_prefix]} rspec" end
        options[:command] ||= "#{rspec_cmd} #{options[:spec]}"
      end
      if options[:and_return]
        options[:command] = "return_to_sesh; #{options[:command]}"
      end
      inferred_location = Inferences.infer_tmux_location
      # puts "Inferred location: #{inferred_location}"
      if options[:pane].nil?
        # puts inferred_location.inspect
        if inferred_location[:project] != @project
          interrupt_and_send_command_to_project! options[:command]
          return 0
        else do_shell_operation_here! options[:command] end
      else
        if inferred_location != { project: @project, pane: options[:pane] }
          interrupt_and_send_command_to_pane! options[:pane], options[:command]
          return 0
        else do_shell_operation_here! options[:command] end
      end
    end
    def do_shell_operation_here!(cmd, allow_zeus_retry=true)
      # system cmd
      raw = ''
      PTY.spawn(cmd) do |reader, writer|
        reader.sync = true
        writer.sync = true
        Thread.new { loop { writer.print(STDIN.getc.chr) } }
        while (c=reader.getc)
          raw << c
          print c
        end
      end
      if allow_zeus_retry && raw =~ /Could not find command "rspec /
        return do_shell_operation_here! cmd, false
      end
      $?.exitstatus
    end

    # Getter methods for passthru to SshControl class
    def project; @project end
    def options; @options end

  end
end

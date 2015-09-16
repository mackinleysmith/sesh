require 'sesh'

module Sesh
  class SshControl
    def initialize(tmux_control, options={})
      @tmux_control = tmux_control
      @project = @tmux_control.project
      @options = DEFAULT_OPTIONS[:ssh].merge(options)
    end

    def connection_command(addr=nil)
      addr ||= @options[:remote_addr]
      tmux_cmd = @tmux_control.connection_command
      return tmux_cmd if addr == @options[:local_addr]
      "ssh #{addr} -t '#{tmux_cmd}'"
    end

    def enter_slave_mode_command(addr=nil)
      @term_app ||= Inferences.infer_terminal_app
      case @term_app
      when 'iTerm'
        tell_term_app = %Q[tell application "#{@term_app}"]
        tell_term_process =
          %Q[tell application "System Events" to tell process "#{@term_app}"]
        cmd = %Q[osascript -e '#{tell_term_app} to activate']
        if @options[:connect_in_new_window]
          cmd += %Q[ -e '#{tell_term_process} to keystroke \"n\" using command down']
          cmd += %Q[ -e 'delay 1']
        end
        cmd += %Q[ -e "#{tell_term_app.gsub('"', '\\"')} to tell session -1] <<
               %Q[ of current terminal to write text \\"#{connection_command(addr)}\\""]

        if @options[:connect_fullscreen]
          # TODO: come up with a non-toggling way to ensure fullscreen
          cmd += %Q[ -e '#{tell_term_process} to keystroke return using command down']
        end
        Sesh.format_command cmd
      when 'Terminal' then Sesh.format_command connection_command(addr)
      end
    end

    def enslave_peer!
      cmd  = %Q[ssh #{@options[:remote_addr]} -t "sesh connect ]
      cmd << %Q[-p #{@project} -R #{@options[:local_addr]}]
      cmd << ' -N' if @options[:connect_in_new_window]
      cmd << ' -F' if @options[:connect_fullscreen]
      cmd << '"'
      system cmd
    end
  end
end

require 'sesh'

module Sesh
  class SshControl
    def initialize(tmux_control, options={})
      @tmux_control = tmux_control
      @project = @tmux_control.project
      @options = DEFAULT_OPTIONS[:ssh].merge(options)
    end

    def connection_command(addr=nil)
      addr ||= @options[:local_addr]
      tmux_cmd = @tmux_control.connection_command
      return tmux_cmd if addr == @options[:local_addr]
      "ssh #{addr} -t '#{tmux_cmd}'"
    end

    def enter_slave_mode_command(addr=nil)
      @term_app ||= Inferences.infer_terminal_app
      case @term_app
      when 'iTerm'
        tell_term_app     = 'tell application "' + @term_app + '"'
        tell_term_process = 'tell application "System Events" to tell process "' + 
                             @term_app + '"'
        Sesh.format_command <<-BASH
          osascript \
                -e '#{tell_term_app} to activate' \
                -e '#{tell_term_process} to keystroke \"n\" using command down' \
                -e 'delay 1' \
                -e "#{tell_term_app.gsub('"', '\\"')} to tell session -1 of current \
                    terminal to write text \\"#{connection_command(addr)}\\"" \
                -e '#{tell_term_process} to keystroke return using command down'
        BASH
      when 'Terminal' then Sesh.format_command connection_command(addr)
      end
    end
  end
end

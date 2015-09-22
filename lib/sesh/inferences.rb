require 'sesh'
require 'tmuxinator'

module Sesh
  module Inferences
    def self.infer_current_directory
      `printf '%q\n' "${PWD##*/}"`.strip
    end
    def self.infer_project_from_current_directory
      inferred_dir = infer_current_directory
      return inferred_dir if Tmuxinator::Config.exists? inferred_dir
    end
    def self.infer_local_ssh_addr
      inferred_user = `echo $USER`.strip
      inferred_hostname = `scutil --get LocalHostName`.strip.downcase
      inferred_hostname += '.local' unless inferred_hostname =~ /\.local$/
      "#{inferred_user}@#{inferred_hostname}"
    end
    def self.infer_terminal_app
      if OS.mac?
        output = `osascript -e 'try' -e 'get exists application "iTerm"' -e 'end try'`.strip
        output.length > 0 ? 'iTerm' : fatal("iTerm 2 is not installed.") # 'Terminal'
        # TODO: support more platforms
      end
    end
    def self.infer_default_editor
      if OS.windows? then 'notepad.exe'
      else o = `echo $EDITOR`.strip; o = 'vim' unless o.length > 0; o end
    end
    def self.infer_tmux_project
      tmux_session_pid = `echo $TMUX | cut -d , -f 2`.strip
      return if tmux_session_pid.length == 0
      tmux_process_line =
        `ps aux | grep tmux | grep #{tmux_session_pid}`.strip.lines.first
      return if tmux_process_line.nil?
      tmux_process_line.split('-s ')[-1].split(' -n')[0]
    end
    def self.infer_tmux_pane
      return if ( o = `echo $TMUX_PANE`.strip ).nil?; o[1..-1].to_i end
    def self.infer_tmux_location; {
      project: infer_tmux_project, pane: infer_tmux_pane } end

    module OS
      def OS.windows?
        (/cygwin|mswin|mingw|bccwin|wince|emx/ =~ RUBY_PLATFORM) != nil end
      def OS.mac?; (/darwin/ =~ RUBY_PLATFORM) != nil end
      def OS.unix?; !OS.windows? end
      def OS.linux?; OS.unix? and not OS.mac? end
    end
  end
end

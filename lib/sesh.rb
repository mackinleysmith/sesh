require 'sesh/version'
require 'sesh/logger'
require 'sesh/inferences'
require 'sesh/ssh_control'
require 'sesh/tmux_control'
require 'sesh/cli'

module Sesh
  HELP_BANNER = <<-HELP
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

  DEFAULT_OPTIONS = {
    project: nil,
    template: nil,
    shell: {
      command: nil,
      pane: nil,
      spec: nil
    },
    ssh: {
      local_addr: nil,
      remote_addr: nil,
      connect_in_new_window: false,
      connect_fullscreen: false
    },
    tmux: { socket_file: nil }
  }
  POSSIBLE_CONFIG_LOCATIONS = %w( sesh_config.yml config/sesh.yml )

  def self.format_command(command) command.gsub(/\ [ ]+/, ' ').strip end
  def self.format_and_run_command(command) `#{format_command(command)}`.strip end
end

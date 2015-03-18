# Sesh: remote background sessions powered by tmux and tmuxinator.
Runs a headless tmuxinator session for remote slave machines to connect to.

## Usage

    sesh command [project]

Leave project blank to use the name of your current directory.

## Commands

    sesh new                           Create a new tmuxinator configuration.
    sesh start [project]               Start a Sesh session for a project.
    sesh stop  [project]               Stop a Sesh session for a project.
    sesh list                          List running Sesh sessions on this machine.
    sesh enslave [project] [user@host] Connect a slave to a local Sesh session.
    sesh connect [project]  user@host  Connect as a slave to a Sesh session.

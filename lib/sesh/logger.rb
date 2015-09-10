require 'sesh'
require 'colorize'

module Sesh
  class Logger
    def self.debug(msg) $stderr.puts "> #{msg}" end
    def self.fatal(msg)
      $stderr.puts msg.red; $stderr.puts; exit 1 end
    def self.warn(msg, nest_level=0)
      $stderr.puts "#{' ' * nest_level * 2}> #{msg}".yellow end
    def self.info(msg, nest_level=0)
      $stdout.puts "#{' ' * nest_level * 2}> #{msg}".blue end
    def self.success(msg, nest_level=0)
      $stdout.puts "#{' ' * nest_level * 2}> #{msg}".green end

    def self.show_progress_until(condition_lambda, timeout=10)
      started_progress_at = Time.now
      return true if condition_lambda[]
      print '> '
      until condition_lambda[] or Time.now - started_progress_at > timeout
        print '.'
        $stdout.flush
        sleep 0.5 
      end
      puts
      return condition_lambda[]
    end

  end
end

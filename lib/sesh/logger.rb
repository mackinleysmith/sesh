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
  end
end

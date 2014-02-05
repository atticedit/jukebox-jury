require 'rubygems'
require 'bundler/setup'
require 'active_record'

project_root = File.dirname(File.absolute_path(__FILE__))
Dir.glob(project_root + "/../models/*.rb").each{|f| require f}

require_relative 'database'
require 'logger'

class Environment
  def self.environment= environment
    @@environment = environment
  end

  def self.database_connection
    Database.connection(@@environment)
  end

  def self.logger
    @@logger ||= Logger.new("logs/#{@@environment}.log")
  end
end

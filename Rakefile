#!/usr/bin/env ruby
# -*- ruby -*-

require_relative 'lib/environment'
require 'rake/testtask'
Rake::TestTask.new() do |t|
  t.pattern = "test/test_*.rb"
end

desc "Run tests"
task :default => :test

task :bootstrap_database do
  require 'sqlite3'
  database = Environment.database_connection("production")
  create_tables(database)
end

task :test_prepare do
  require 'sqlite3'
  File.delete("db/jury_test.sqlite3")
  database = Environment.database_connection("test")
  create_tables(database)
end

def create_tables(database_connection)
  database_connection.execute("CREATE TABLE songs (id INTEGER PRIMARY KEY AUTOINCREMENT, name varchar(50), artist varchar(50), genre varchar(50), intensity integer, focusing boolean)")
end

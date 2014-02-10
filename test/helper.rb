require 'minitest/autorun'
require_relative '../lib/environment'

class JuryTest < MiniTest::Unit::TestCase
  def setup
    Environment.environment = "test"
    Environment.connect_to_database
  end

  def teardown
    # The Database Cleaner gem will do this for us:
    Genre.destroy_all
    Song.destroy_all
  end

  def execute_popen command
    shell_output = ""
    IO.popen("#{command} --environment test", 'r+') do |pipe|
      pipe.puts ""
      shell_output = pipe.read
    end
    shell_output
  end

  def assert_third_to_last_command_output expected, command
    shell_output = execute_popen(command)
    actual = shell_output.strip.split("\n")[-3]
    assert_equal expected, actual
  end

  def assert_second_to_last_command_output expected, command
    shell_output = execute_popen(command)
    actual = shell_output.strip.split("\n")[-2]
    assert_equal expected, actual
  end

  def assert_last_command_output expected, command
    shell_output = execute_popen(command)
    actual = shell_output.strip.split("\n").last
    assert_equal expected, actual
  end

  def assert_in_output output, *args
    missing_content = []
    args.each do |argument|
      unless output.include?(argument)
        missing_content << argument
      end
    end
    assert missing_content.empty?, "Output didn't include #{missing_content.join(", ")}:\n #{output}"
  end

  def assert_not_in_output output, *args
    args.each do |argument|
      assert !output.include?(argument), "Output shouldn't include #{argument}: #{output}"
    end
  end

  def assert_includes_in_order(actual, *expected_items)
    regexp_string = expected_items.join(".*").gsub("?","\\?").gsub("$", "\\$")
    assert_match /#{regexp_string}/, actual.delete("\n"), "Expected /#{regexp_string}/ to match:\n\n" + actual
  end
end

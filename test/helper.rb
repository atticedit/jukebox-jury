require 'minitest/autorun'

def assert_command_output expected, command
  actual = `#{command}`.strip
  assert_equal expected, actual
end

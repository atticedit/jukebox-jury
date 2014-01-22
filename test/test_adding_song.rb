require_relative 'helper'

class TestAddingSong < MiniTest::Unit::TestCase

  def test_error_message_for_missing_song_name
    command = "./jury add"
    expected = "You must provide the name of the song you\'re adding."
    assert_command_output expected, command
  end

  def test_valid_song_information_gets_saved
    skip "needs implementation"
    assert false, "Missing test implementation"
  end

  def test_invalid_song_information_doesnt_get_saved
    skip "needs implementation"
    assert false, "Missing test implementation"
  end

end

require_relative 'helper'

class TestEditingSongs < JuryTest
  def test_editing_a_record_that_exists
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Cruso", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    id = song.id
    command = "./jury edit --id #{id} --name 'Crusoe' --artist 'The Ex & Tom Cora' --intensity 4 --focusing 1"
    expected = "I\'ve updated song #{id}, \"Crusoe\" by The Ex & Tom Cora, in the database."
    assert_second_to_last_command_output expected, command
    expected = "    It's punk with an intensity of 4 and a focusing value of true."
    assert_last_command_output expected, command
  end

  def test_attempting_to_edit_a_nonexistent_record
    command = "./jury edit --id 314159 --name 'Crusoe' --artist 'The Ex & Tom Cora' --intensity 4 --focusing 1"
    expected = "Hmm. Song 314159 couldn't be found."
    assert_last_command_output expected, command
  end

  def test_attempting_to_edit_with_no_changes
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    id = song.id
    command = "./jury edit --id #{id} --name 'Crusoe' --artist 'The Ex & Tom Cora' --intensity 4 --focusing 1"
    expected = "I\'ve updated song #{id}, \"Crusoe\" by The Ex & Tom Cora, in the database."
    assert_second_to_last_command_output expected, command
    expected = "    It's punk with an intensity of 4 and a focusing value of true."
    assert_last_command_output expected, command
  end

  def test_editing_only_song_name
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Cruso", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    id = song.id
    command = "./jury edit --id #{id} --name 'Crusoe'"
    expected = "I\'ve updated song #{id}, \"Crusoe\" by The Ex & Tom Cora, in the database."
    assert_second_to_last_command_output expected, command
    expected = "    It's punk with an intensity of 4 and a focusing value of true."
    assert_last_command_output expected, command
  end

  def test_editing_only_intensity
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 1, focusing: 1)
    id = song.id
    command = "./jury edit --id #{id} --name 'Crusoe' --intensity 4"
    expected = "I\'ve updated song #{id}, \"Crusoe\" by The Ex & Tom Cora, in the database."
    assert_second_to_last_command_output expected, command
    expected = "    It's punk with an intensity of 4 and a focusing value of true."
    assert_last_command_output expected, command
  end
end

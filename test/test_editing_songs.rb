require_relative 'helper'

class TestEditingSongs < JuryTest
  def test_updating_a_record_that_exists
    genre = Genre.find_or_create("Punk")
    song = Song.new(name: "Cruso", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    song.save
    id = song.id
    command = "./jury edit --id #{id} --name 'Crusoe' --artist 'The Ex & Tom Cora' --intensity 4 --focusing 1"
    expected = "Song #{id} by The Ex & Tom Cora is now named 'Crusoe'. It's in the Punk genre, with intensity of 4 and focusing value of 1."
    assert_command_output expected, command
  end

  def test_attempting_to_update_a_nonexistent_record
    command = "./jury edit --id 314159 --name 'Crusoe' --artist 'The Ex & Tom Cora' --intensity 4 --focusing 1"
    expected = "Song 314159 couldn't be found."
    assert_command_output expected, command
  end

  def test_attempting_to_update_with_no_changes
    genre = Genre.find_or_create("Punk")
    song = Song.new(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    song.save
    id = song.id
    command = "./jury edit --id #{id} --name 'Crusoe' --artist 'The Ex & Tom Cora' --intensity 4 --focusing 1"
    expected = "Song #{id} by The Ex & Tom Cora is now named 'Crusoe'. It's in the Punk genre, with intensity of 4 and focusing value of 1."
    assert_command_output expected, command
  end

  def test_updating_only_song_name
    genre = Genre.find_or_create("Punk")
    song = Song.new(name: "Cruso", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    song.save
    id = song.id
    command = "./jury edit --id #{id} --name 'Crusoe'"
    expected = "Song #{id} by The Ex & Tom Cora is now named 'Crusoe'. It's in the Punk genre, with intensity of 4 and focusing value of 1."
    assert_command_output expected, command
  end

  def test_updating_only_intensity
    genre = Genre.find_or_create("Punk")
    song = Song.new(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 1, focusing: 1)
    song.save
    id = song.id
    command = "./jury edit --id #{id} --intensity 4"
    expected = "Song #{id} by The Ex & Tom Cora is now named 'Crusoe'. It's in the Punk genre, with intensity of 4 and focusing value of 1."
    assert_command_output expected, command
  end
end

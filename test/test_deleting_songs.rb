require_relative 'helper'

class TestDeletingSongs < JuryTest
  def test_user_asked_to_verify_deletion
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    shell_output = ""
    IO.popen("./jury delete 'Crusoe' --environment test", 'r+') do |pipe|
      pipe.puts "Y"
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output,
      "I\'ve found a song named \"Crusoe\" by The Ex & Tom Cora."
      "It's in the Punk genre, with intensity of 4 and focusing value of 1."
      "Are you sure you want to delete \"Crusoe\"?"
      "Enter 'Y' for yes or 'N' for no, then hit return."
  end

  def test_user_verifies_deletion
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    shell_output = ""
    IO.popen("./jury delete 'Crusoe' --environment test", 'r+') do |pipe|
      pipe.puts "Y"
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output,
      "I\'ve deleted \"Crusoe\" from the database."
  end

  def test_user_declines_deletion
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    shell_output = ""
    IO.popen("./jury delete 'Crusoe' --environment test", 'r+') do |pipe|
      pipe.puts "N"
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output,
      "\"Crusoe\" wasn\'t deleted, and remains in the database."
  end

  def test_user_enters_bad_input_for_deletion_verification
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    shell_output = ""
    IO.popen("./jury delete 'Crusoe' --environment test", 'r+') do |pipe|
      pipe.puts "X"
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output,
      "Sorry, I don't understand what you mean by \'X'.",
      "I was looking for 'Y' or 'N'.",
      "\"Crusoe\" wasn\'t deleted, and remains in the database."
  end

  def test_delete_deletes_row
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    song_count_before_delete = Song.count
    IO.popen("./jury delete 'Crusoe' --environment test", 'r+') do |pipe|
      pipe.puts "Y"
    end
    song_count_after_delete = Song.count
    assert_equal song_count_before_delete - 1, song_count_after_delete
  end

  def test_delete_deletes_song
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    id = song.id
    IO.popen("./jury delete 'Crusoe' --environment test", 'r+') do |pipe|
      pipe.puts "Y"
    end
    assert_nil Song.find_by(id: id)
  end

  def test_declining_deletion_doesnt_delete_row
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    song_count_before_declining_delete = Song.count
    IO.popen("./jury delete 'Crusoe' --environment test", 'r+') do |pipe|
      pipe.puts "N"
    end
    song_count_after_declining_delete = Song.count
    assert_equal song_count_before_declining_delete, song_count_after_declining_delete
  end

  def test_declining_deletion_doesnt_delete_song
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    id = song.id
    IO.popen("./jury delete 'Crusoe' --environment test", 'r+') do |pipe|
      pipe.puts "N"
    end
    old_song = Song.find(id)
    assert_equal id, old_song.id
  end

  def test_error_message_for_missing_song_to_delete
    command = "./jury delete"
    expected = "I\'ll need the name of the song you want to delete."
    assert_third_to_last_command_output expected, command
  end

  def test_error_message_when_song_to_delete_isnt_found
    genre = Genre.find_or_create_by(name: "Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    shell_output = ""
    IO.popen("./jury delete 'Cattle Drive' --environment test") do |pipe|
      shell_output = pipe.read
    end
    assert_includes shell_output,
      "I don't find any songs named \"Cattle Drive\" in the database."
  end
end

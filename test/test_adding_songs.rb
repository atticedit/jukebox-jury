require_relative 'helper'

class TestAddingSongs < JuryTest
  def test_user_is_presented_with_list_of_genres
    gen1 = Genre.find_or_create("Jazz")
    gen2 = Genre.find_or_create("Punk")
    gen3 = Genre.find_or_create("Classical")
    shell_output = ""
    IO.popen("./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --intensity 5 --focusing 0 --environment test", 'r+') do |pipe|
      pipe.puts "2"
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output,
      "Enter the number representing the song's genre, and hit return:",
      "1. Classical",
      "2. Jazz",
      "3. Punk"
  end

  def test_user_chooses_genre
    gen1 = Genre.find_or_create("Jazz")
    gen2 = Genre.find_or_create("Punk")
    gen3 = Genre.find_or_create("Classical")
    shell_output = ""
    IO.popen("./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --intensity 5 --focusing 0 --environment test", 'r+') do |pipe|
      pipe.puts "3"
      shell_output = pipe.read
    end
    expected = "I added a song by Hüsker Dü named 'Celebrated Summer'. It's in the Punk genre, with intensity of 5 and focusing value of 0."
    assert_in_output shell_output, expected
  end

  def test_user_skips_entering_genre
    gen2 = Genre.find_or_create("Punk")
    shell_output = ""
    IO.popen("./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --intensity 5 --focusing 0 --environment test", 'r+') do |pipe|
      pipe.puts ""
      shell_output = pipe.read
    end
    expected = "I added a song by Hüsker Dü named 'Celebrated Summer'. It's in the Unclassified genre, with intensity of 5 and focusing value of 0."
    assert_in_output shell_output, expected
  end

  def test_valid_song_gets_saved
    execute_popen("./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --intensity 5 --focusing 0")
    database.results_as_hash = false
    results = database.execute("select name, artist, intensity, focusing from songs")
    expected = ["Celebrated Summer", "Hüsker Dü", 5, 0]
    assert_equal expected, results[0]
    assert_equal 1, Song.count
  end

  def test_invalid_song_doesnt_get_saved
    execute_popen("./jury add 'Celebrated Summer' --artist 'Hüsker Dü'")
    assert_equal 0, Song.count
  end

  def test_error_message_for_missing_song_name
    command = "./jury add"
    expected = "I\'ll need the name of the song you\'re adding. I\'ll need the artist and intensity and focusing value of the song you\'re adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_artist
    command = "./jury add 'Celebrated Summer' --intensity 5 --focusing 0"
    expected = "I\'ll need the artist of the song you\'re adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_intensity
    command = "./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --focusing 0"
    expected = "I\'ll need the intensity of the song you\'re adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_focusing
    command = "./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --intensity 5"
    expected = "I\'ll need the focusing value of the song you\'re adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_artist_and_intensity_and_focusing
    command = "./jury add 'Celebrated Summer'"
    expected = "I\'ll need the artist and intensity and focusing value of the song you\'re adding."
    assert_command_output expected, command
  end
end

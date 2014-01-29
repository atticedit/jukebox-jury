require_relative 'helper'

class TestAddingSongs < JuryTest

  def test_valid_song_gets_saved
    `./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --genre Punk --intensity 5 --focusing 0 --environment test`
    results = database.execute("select name, artist, genre, intensity, focusing from songs")
    expected = ["Celebrated Summer", "Hüsker Dü", "Punk", 5, 0]
    assert_equal expected, results[0]

    result = database.execute("select count(id) from songs")
    assert_equal 1, result[0][0]
  end

  def test_invalid_song_doesnt_get_saved
    `./jury add 'Celebrated Summer' --artist 'Hüsker Dü'`
    result = database.execute("select count(id) from songs")
    assert_equal 0, result[0][0]
  end

  def test_valid_song_information_gets_printed
    command = "./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --genre Punk --intensity 5 --focusing 0"
    expected = "A song by Hüsker Dü was added, named 'Celebrated Summer'.\nIt's in the Punk genre, with intensity of 5 and focusing value of 0."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_song_name
    command = "./jury add"
    expected = "You must provide the name of the song you\'re adding.\nYou must provide the artist and genre and intensity and focusing value of the song you\'re adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_artist
    command = "./jury add 'Celebrated Summer' --genre Punk --intensity 5 --focusing 0"
    expected = "You must provide the artist of the song you\'re adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_genre
    command = "./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --intensity 5 --focusing 0"
    expected = "You must provide the genre of the song you\'re adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_intensity
    command = "./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --genre Punk --focusing 0"
    expected = "You must provide the intensity of the song you\'re adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_focusing
    command = "./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --genre Punk --intensity 5"
    expected = "You must provide the focusing value of the song you\'re adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_genre_and_focusing
    command = "./jury add 'Celebrated Summer' --artist 'Hüsker Dü' --intensity 5"
    expected = "You must provide the genre and focusing value of the song you\'re adding."
    assert_command_output expected, command
  end

  def test_error_message_for_missing_artist_and_genre_and_intensity_and_focusing
    command = "./jury add 'Celebrated Summer'"
    expected = "You must provide the artist and genre and intensity and focusing value of the song you\'re adding."
    assert_command_output expected, command
  end

end

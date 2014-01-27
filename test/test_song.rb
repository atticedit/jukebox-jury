require_relative 'helper'
require_relative '../models/song'

class TestSong < JuryTest
  def test_to_s_prints_details
    song = Song.new(name: "Mercy Mercy", artist: "Booker T. & The MGs", genre: "Soul", intensity: 4, focusing: 1)
    expected = "\'Mercy Mercy\' by Booker T. & The MGs, Soul, intensity: 4, focusing value: 1"
    assert_equal expected, song.to_s
  end

  def test_all_returns_all_songs_in_alphabetical_order
    database.execute('insert into songs(name, artist, genre, intensity, focusing) values("Tune Up", "Chet Baker", "Jazz", 4, 1)')
    database.execute('insert into songs(name, artist, genre, intensity, focusing) values("Out Of Body", "Japanther", "Punk", 4, 1)')
    results = Song.all
    expected = ["Out Of Body", "Tune Up"]
    actual = results.map{ |song| song.name }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_songs
    results = Song.all
    assert_equal [], results
  end
end

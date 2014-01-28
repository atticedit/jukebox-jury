require_relative 'helper'
require_relative '../models/song'

class TestSong < JuryTest
  def test_to_s_prints_details
    song = Song.new(name: "Mercy Mercy", artist: "Booker T. & The MGs", genre: "Soul", intensity: 4, focusing: 1)
    expected = "\'Mercy Mercy\' by Booker T. & The MGs, Soul, intensity: 4, focusing value: 1, id: #{song.id}"
    assert_equal expected, song.to_s
  end

  def test_save_saves_songs
    song = Song.new(name: "Crusoe", artist: "The Ex & Tom Cora", genre: "Punk", intensity: 4, focusing: 1)
    song_count_before_save = database.execute("select count(id) from songs")[0][0]
    song.save
    songs_count_after_save = database.execute("select count(id) from songs")[0][0]
    assert_equal song_count_before_save + 1, songs_count_after_save
  end

  def test_save_creates_an_id
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: "Punk", intensity: 4, focusing: 1)
    refute_nil song.id, "Song id shouldn't be nil"
  end

  def test_all_returns_all_songs_in_alphabetical_order
    Song.create(name: "Tune Up", artist: "Chet Baker", genre: "Jazz", intensity: 4, focusing: 1)
    Song.create(name: "Out Of Body", artist: "Japanther", genre: "Punk", intensity: 4, focusing: 1)
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

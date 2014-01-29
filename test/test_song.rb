require_relative 'helper'
require_relative '../models/song'

class TestSong < JuryTest
  def test_to_s_prints_details
    song = Song.new(name: "Mercy Mercy", artist: "Booker T. & The MGs", genre: "Soul", intensity: 4, focusing: 1)
    expected = "\'Mercy Mercy\' by Booker T. & The MGs, Soul, intensity: 4, focusing value: 1, id: #{song.id}"
    assert_equal expected, song.to_s
  end

  def test_update_doesnt_insert_new_row
    song = Song.new(name: "Cruso", artist: "The Ex & Tom Cora", genre: "Punk", intensity: 4, focusing: 1)
    song_count_before_update = database.execute("select count(id) from songs")[0][0]
    song.update(name: "Crusoe")
    songs_count_after_update = database.execute("select count(id) from songs")[0][0]
    assert_equal song_count_before_update + 1, songs_count_after_update
  end

  def test_update_saves_to_the_database
    song = Song.create(name: "Cruso", artist: "The Ex", genre: "Unk", intensity: 3, focusing: 0)
    id = song.id
    song.update(name: "Crusoe", artist: "The Ex & Tom Cora", genre: "Punk", intensity: 4, focusing: 1)
    updated_song = Song.find(id)
    expected = ["Crusoe", "The Ex & Tom Cora", "Punk", 4, 1]
    actual = [updated_song.name, updated_song.artist, updated_song.genre, updated_song.intensity, updated_song.focusing]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    song = Song.create(name: "Cruso", artist: "The Ex", genre: "Unk", intensity: 3, focusing: 0)
    song.update(name: "Crusoe", artist: "The Ex & Tom Cora", genre: "Punk", intensity: 4, focusing: 1)
    expected = ["Crusoe", "The Ex & Tom Cora", "Punk", 4, 1]
    actual = [song.name, song.artist, song.genre, song.intensity, song.focusing]
    assert_equal expected, actual
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

  def test_find_returns_nil_if_song_id_doesnt_exist
    assert_nil Song.find(314159)
  end

  def test_find_returns_the_row_as_song_object
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: "Punk", intensity: 4, focusing: 1)
    found = Song.find(song.id)
    assert_equal song.name, found.name
    assert_equal song.id, found.id
  end

  def test_search_returns_song_objects
    Song.create(name: "Pancake Lizard", artist: "Aphex Twin", genre: "Electronic", intensity: 3, focusing: 0)
    Song.create(name: "Cantus In Memory Of Benjamin Britten", artist: "Arvo Pärt", genre: "Classical", intensity: 4, focusing: 1)
    Song.create(name: "Yègellé Tezeta (My Own Memory)", artist: "Mulatu Astatke", genre: "Ethiopian Jazz", intensity: 4, focusing: 1)
    results = Song.search("Memory")
    assert results.all?{ |result| result.is_a? Song }, "Not all results were songs."
  end

  def test_search_returns_appropriate_results
    song1 = Song.create(name: "Pancake Lizard", artist: "Aphex Twin", genre: "Electronic", intensity: 3, focusing: 0)
    song2 = Song.create(name: "Cantus In Memory Of Benjamin Britten", artist: "Arvo Pärt", genre: "Classical", intensity: 4, focusing: 1)
    song3 = Song.create(name: "Yègellé Tezeta (My Own Memory)", artist: "Mulatu Astatke", genre: "Ethiopian Jazz", intensity: 4, focusing: 1)
    expected = [song2, song3]
    actual = Song.search("Memory")
    assert_equal expected, actual
  end

  def test_search_returns_empty_array_if_no_results
    Song.create(name: "Pancake Lizard", artist: "Aphex Twin", genre: "Electronic", intensity: 3, focusing: 0)
    Song.create(name: "Cantus In Memory Of Benjamin Britten", artist: "Arvo Pärt", genre: "Classical", intensity: 4, focusing: 1)
    Song.create(name: "Yègellé Tezeta (My Own Memory)", artist: "Mulatu Astatke", genre: "Ethiopian Jazz", intensity: 4, focusing: 1)
    results = Song.search("Cattle")
    assert_equal [], results
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

  def test_equality_on_same_object
    song = Song.create(name: "Tune Up", artist: "Chet Baker", genre: "Jazz", intensity: 4, focusing: 1)
    assert song == song
  end

  def test_equality_with_different_class
    song = Song.create(name: "Tune Up", artist: "Chet Baker", genre: "Jazz", intensity: 4, focusing: 1)
    refute song == "Song"
  end

  def test_equality_with_different_song
    song1 = Song.create(name: "Tune Up", artist: "Chet Baker", genre: "Jazz", intensity: 4, focusing: 1)
    song2 = Song.create(name: "Out Of Body", artist: "Japanther", genre: "Punk", intensity: 4, focusing: 1)
    refute song1 == song2
  end

  def test_equality_with_same_song_with_different_object_id
    song1 = Song.create(name: "Tune Up", artist: "Chet Baker", genre: "Jazz", intensity: 4, focusing: 1)
    song2 = Song.find(song1.id)
    assert song1 == song2
  end
end

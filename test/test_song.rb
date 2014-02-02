require_relative 'helper'
require_relative '../models/song'

class TestSong < JuryTest
  def test_to_s_prints_details
    skip
    genre = Genre.find_or_create("Soul")
    song = Song.new(name: "Mercy Mercy", artist: "Booker T. & The MGs", genre: genre.name, intensity: 4, focusing: 1)
    expected = "\'Mercy Mercy\' by Booker T. & The MGs, Soul, intensity: 4, focusing value: 1, id: #{song.id}"
    assert_equal expected, song.to_s
  end

  def test_update_doesnt_insert_new_row
    genre = Genre.find_or_create("Punk")
    song = Song.new(name: "Cruso", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    song_count_before_update = database.execute("select count(id) from songs")[0][0]
    song.update(name: "Crusoe")
    song_count_after_update = database.execute("select count(id) from songs")[0][0]
    assert_equal song_count_before_update + 1, song_count_after_update
  end

  def test_update_saves_to_the_database
    skip
    genre = Genre.find_or_create("Unk")
    song = Song.create(name: "Cruso", artist: "The Ex", genre: genre, intensity: 3, focusing: 0)
    id = song.id
    genre = Genre.find_or_create("Punk")
    song.update(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    updated_song = Song.find(id)
    expected = ["Crusoe", "The Ex & Tom Cora", "Punk", 4, 1]
    actual = [updated_song.name, updated_song.artist, updated_song.genre, updated_song.intensity, updated_song.focusing]
    assert_equal expected, actual
  end

  def test_update_is_reflected_in_existing_instance
    genre = Genre.find_or_create("Unk")
    song = Song.create(name: "Cruso", artist: "The Ex", genre: genre, intensity: 3, focusing: 0)
    genre = Genre.find_or_create("Punk")
    song.update(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    expected = ["Crusoe", "The Ex & Tom Cora", "Punk", 4, 1]
    actual = [song.name, song.artist, song.genre.name, song.intensity, song.focusing]
    assert_equal expected, actual
  end

  def test_save_saves_songs
    genre = Genre.find_or_create("Punk")
    song = Song.new(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    song_count_before_save = database.execute("select count(id) from songs")[0][0]
    song.save
    songs_count_after_save = database.execute("select count(id) from songs")[0][0]
    assert_equal song_count_before_save + 1, songs_count_after_save
  end

  def test_save_creates_an_id
    genre = Genre.find_or_create("Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    refute_nil song.id, "Song id shouldn't be nil"
  end

  def test_save_saves_genre_id
    skip
    genre = Genre.find_or_create("Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    genre_id = database.execute("select genre_id from songs where id='#{song.id}'")[0][0]
    assert_equal genre.id, genre_id, "Genre.id and song.genre_id should be the same"
  end

  def test_save_updates_genre_id
    skip
    genre1 = Genre.find_or_create("Punk")
    genre2 = Genre.find_or_create("Jazz")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre1, intensity: 4, focusing: 1)
    song.genre = genre2
    song.save
    genre_id = database.execute("select genre_id from songs where id='#{song.id}'")[0][0]
    assert_equal genre2.id, genre_id, "Genre2.id and song.genre_id should be the same"
  end

  def test_find_returns_nil_if_song_id_doesnt_exist
    assert_nil Song.find(314159)
  end

  def test_find_returns_the_row_as_song_object
    genre = Genre.find_or_create("Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    found = Song.find(song.id)
    assert_equal song.name, found.name
    assert_equal song.id, found.id
  end

  def test_search_returns_song_objects
    genre = Genre.find_or_create("Electronic")
    Song.create(name: "Pancake Lizard", artist: "Aphex Twin", genre: genre, intensity: 3, focusing: 0)
    genre = Genre.find_or_create("Classical")
    Song.create(name: "Cantus In Memory Of Benjamin Britten", artist: "Arvo Pärt", genre: genre, intensity: 4, focusing: 1)
    genre = Genre.find_or_create("Ethiopian Jazz")
    Song.create(name: "Yègellé Tezeta (My Own Memory)", artist: "Mulatu Astatke", genre: genre, intensity: 4, focusing: 1)
    results = Song.search("Memory")
    assert results.all?{ |result| result.is_a? Song }, "Not all results were songs."
  end

  def test_search_returns_appropriate_results
    skip
    genre = Genre.find_or_create("Electronic")
    song1 = Song.create(name: "Pancake Lizard", artist: "Aphex Twin", genre: genre, intensity: 3, focusing: 0)
    genre = Genre.find_or_create("Classical")
    song2 = Song.create(name: "Cantus In Memory Of Benjamin Britten", artist: "Arvo Pärt", genre: genre, intensity: 4, focusing: 1)
    genre = Genre.find_or_create("Ethiopian Jazz")
    song3 = Song.create(name: "Yègellé Tezeta (My Own Memory)", artist: "Mulatu Astatke", genre: genre, intensity: 4, focusing: 1)
    expected = [song2, song3]
    actual = Song.search("Memory")
    assert_equal expected, actual
  end

  def test_search_returns_empty_array_if_no_results
    genre = Genre.find_or_create("Electronic")
    Song.create(name: "Pancake Lizard", artist: "Aphex Twin", genre_id: genre.id, intensity: 3, focusing: 0)
    genre = Genre.find_or_create("Classical")
    Song.create(name: "Cantus In Memory Of Benjamin Britten", artist: "Arvo Pärt", genre: genre, intensity: 4, focusing: 1)
    genre = Genre.find_or_create("Ethiopian Jazz")
    Song.create(name: "Yègellé Tezeta (My Own Memory)", artist: "Mulatu Astatke", genre: genre, intensity: 4, focusing: 1)
    results = Song.search("Cattle")
    assert_equal [], results
  end

  def test_all_returns_all_songs_in_alphabetical_order
    genre = Genre.find_or_create("Jazz")
    Song.create(name: "Tune Up", artist: "Chet Baker", genre: genre, intensity: 4, focusing: 1)
    genre = Genre.find_or_create("Punk")
    Song.create(name: "Out Of Body", artist: "Japanther", genre: genre, intensity: 4, focusing: 1)
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
    genre = Genre.find_or_create("Jazz")
    song = Song.create(name: "Tune Up", artist: "Chet Baker", genre: genre, intensity: 4, focusing: 1)
    assert song == song
  end

  def test_equality_with_different_class
    genre = Genre.find_or_create("Jazz")
    song = Song.create(name: "Tune Up", artist: "Chet Baker", genre: genre, intensity: 4, focusing: 1)
    refute song == "Song"
  end

  def test_equality_with_different_song
    genre = Genre.find_or_create("Jazz")
    song1 = Song.create(name: "Tune Up", artist: "Chet Baker", genre: genre, intensity: 4, focusing: 1)
    genre = Genre.find_or_create("Punk")
    song2 = Song.create(name: "Out Of Body", artist: "Japanther", genre: genre, intensity: 4, focusing: 1)
    refute song1 == song2
  end

  def test_equality_with_same_song_with_different_object_id
    skip
    genre = Genre.find_or_create("Jazz")
    song1 = Song.create(name: "Tune Up", artist: "Chet Baker", genre: genre, intensity: 4, focusing: 1)
    song2 = Song.find(song1.id)
    assert song1 == song2
  end
end

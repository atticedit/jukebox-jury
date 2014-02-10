require_relative 'helper'

class TestSong < JuryTest
  def test_count_when_no_songs
    assert_equal 0, Song.count
  end

  def test_count_of_multiple_songs
    Song.create(name: "Mercy Mercy", artist: "Booker T. & The MGs", intensity: 4, focusing: 1)
    Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", intensity: 4, focusing: 1)
    Song.create(name: "Pancake Lizard", artist: "Aphex Twin", intensity: 3, focusing: 0)
    assert_equal 3, Song.count
  end

  def test_genre_defaults_to_unclassified
    song = Song.create(name: "Mercy Mercy", artist: "Booker T. & The MGs", intensity: 4, focusing: 1)
    assert_equal "Unclassified", song.genre.name
  end

  def test_to_s_prints_details
    song = Song.create(name: "Mercy Mercy", artist: "Booker T. & The MGs", intensity: 4, focusing: 1)
    expected = "\"Mercy Mercy\" by Booker T. & The MGs, Unclassified, intensity: 4, focusing value: 1, id: #{song.id}"
    assert_equal expected, song.to_s
  end

  def test_edit_doesnt_insert_new_row
    genre = Genre.find_or_create("Punk")
    song = Song.create(name: "Cruso", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    song_count_before_edit = Song.count
    song.edit(name: "Crusoe")
    song_count_after_edit = Song.count
    assert_equal song_count_before_edit, song_count_after_edit
  end

  def test_edit_saves_to_the_database
    song = Song.create(name: "Cruso", artist: "The Ex", intensity: 3, focusing: 0)
    id = song.id
    song.edit(name: "Crusoe", artist: "The Ex & Tom Cora", intensity: 4, focusing: 1)
    edited_song = Song.find(id)
    expected = ["Crusoe", "The Ex & Tom Cora", 4, 1]
    actual = [edited_song.name, edited_song.artist, edited_song.intensity, edited_song.focusing]
    assert_equal expected, actual
  end

  def test_edit_is_reflected_in_existing_instance
    genre = Genre.find_or_create("Unk")
    song = Song.create(name: "Cruso", artist: "The Ex", genre: genre, intensity: 3, focusing: 0)
    genre = Genre.find_or_create("Punk")
    song.edit(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    expected = ["Crusoe", "The Ex & Tom Cora", "Punk", 4, 1]
    actual = [song.name, song.artist, song.genre.name, song.intensity, song.focusing]
    assert_equal expected, actual
  end

  def test_save_saves_songs
    genre = Genre.find_or_create("Punk")
    song = Song.new(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    song_count_before_save = Song.count
    song.save
    songs_count_after_save = Song.count
    assert_equal song_count_before_save + 1, songs_count_after_save
  end

  def test_save_creates_an_id
    genre = Genre.find_or_create("Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    refute_nil song.id, "Song id shouldn't be nil"
  end

  def test_save_saves_genre_id
    genre = Genre.find_or_create("Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    genre_id = Song.find(song.id).genre.id
    assert_equal genre.id, genre_id, "Genre.id and song.genre_id should be the same"
  end

  def test_save_edits_genre_id
    genre1 = Genre.find_or_create("Punk")
    genre2 = Genre.find_or_create("Jazz")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre1, intensity: 4, focusing: 1)
    song.genre = genre2
    song.save
    genre_id = Song.find(song.id).genre.id
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
    assert_equal song.artist, found.artist
    assert_equal song.intensity, found.intensity
    assert_equal song.focusing, found.focusing
  end

  def test_find_returns_the_song_with_correct_genre
    genre = Genre.find_or_create("Punk")
    song = Song.create(name: "Crusoe", artist: "The Ex & Tom Cora", genre: genre, intensity: 4, focusing: 1)
    found = Song.find(song.id)
    refute_equal Genre.default.id, found.genre.id
    assert_equal genre.id, found.genre.id
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
    genre = Genre.find_or_create("Jazz")
    song1 = Song.create(name: "Tune Up", artist: "Chet Baker", genre: genre, intensity: 4, focusing: 1)
    song2 = Song.find(song1.id)
    assert song1 == song2
  end
end

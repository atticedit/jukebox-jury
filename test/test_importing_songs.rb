require_relative 'helper'
require_relative '../lib/importer'

class TestImportingSongs < JuryTest
  def import_data
    Importer.import("test/sample_song_data.csv")
  end

  def test_the_correct_number_of_songs_are_imported
    import_data
    assert_equal 3, Song.all.count
  end

  def test_songs_are_imported_fully
    skip
    import_data
    expected = ["Parchman Farm Blues,Bukka White,Blues,3,0",
    "Telford Reprise,Swearing At Motorists,Indie Rock,2,1",
    "Make The Road By Walking,Menahan Street Band,Funk,3,1"]
    actual = Song.all.map do |song|
      "#{song.name}, #{song.artist}, #{song.genre.name}, #{song.intensity}, #{song.focusing}"
    end
    assert_equal expected, actual
  end

  def test_extra_genres_arent_created
    import_data
    assert_equal 3, Genre.all.count
  end

  def test_genres_are_created_as_needed
    Genre.find_or_create("Funk")
    Genre.find_or_create("Jazz")
    import_data
    assert_equal 4, Genre.all.count, "The genres are: #{Genre.all.map(&:name)}"
  end

  def test_data_isnt_duplicated
    import_data
    expected = ["Blues", "Funk", "Indie Rock"]
    assert_equal expected, Genre.all.map(&:name)
  end
end

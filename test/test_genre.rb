require_relative 'helper'

class TestGenre < JuryTest
  def test_default_creates_correctly_named_file
    genre = Genre.default
    assert_equal "Unclassified", genre.name
    refute genre.new_record?
  end

  def test_default_creates_genre
    assert_equal 0, Genre.count
    Genre.default
    assert_equal 1, Genre.count
  end

  def test_default_doesnt_create_duplicate_default
    genre = Genre.find_or_create_by(name: "Unclassified")
    assert_equal genre.id, Genre.default.id
    assert_equal 1, Genre.count
  end

  def test_count_when_no_genres
    assert_equal 0, Genre.count
  end

  def test_count_of_multiple_genres
    Genre.find_or_create_by(name: "Jazz")
    Genre.find_or_create_by(name: "Funk")
    Genre.find_or_create_by(name: "Punk")
    assert_equal 3, Genre.count
  end

  def test_genres_are_created_if_they_dont_exist
    genre_count_before_import = Genre.count
    Genre.find_or_create_by(name: "Rock")
    genre_count_after_import = Genre.count
    assert_equal genre_count_before_import + 1, genre_count_after_import
  end

  def test_genres_arent_created_if_they_already_exist
    Genre.find_or_create_by(name: "Jazz")
    genre_count_before_import = Genre.count
    Genre.find_or_create_by(name: "Jazz")
    genre_count_after_import = Genre.count
    assert_equal genre_count_before_import, genre_count_after_import
  end

  def test_existing_genre_is_returned_by_find_or_create_by_name
    genre1 = Genre.find_or_create_by(name: "Jazz")
    genre2 = Genre.find_or_create_by(name: "Jazz")
    assert_equal genre1.id, genre2.id, "Genre ids should be identical"
  end

  def test_find_or_create_creates_an_id
    genre = Genre.find_or_create_by(name: "Funk")
    refute_nil genre.id, "Genre id shouldn't be nil"
  end

  def test_all_returns_all_genres_in_alphabetical_order
    Genre.find_or_create_by(name: "Jazz")
    Genre.find_or_create_by(name: "Funk")
    expected = ["Funk", "Jazz"]
    actual = Genre.all.map{ |genre| genre.name }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_genres
    results = Genre.all
    assert_equal [], results
  end
end

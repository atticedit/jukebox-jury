require_relative 'helper'

class TestGenre < JuryTest
  def test_count_when_no_genres
    assert_equal 0, Genre.count
  end

  def test_count_of_multiple_genres
    Genre.find_or_create("Jazz")
    Genre.find_or_create("Funk")
    Genre.find_or_create("Punk")
    assert_equal 3, Genre.count
  end

  def test_genres_are_created_if_they_dont_exist
    genre_count_before_import = Genre.count
    Genre.find_or_create("Rock")
    genre_count_after_import = Genre.count
    assert_equal genre_count_before_import + 1, genre_count_after_import
  end

  def test_genres_arent_created_if_they_already_exist
    Genre.find_or_create("Jazz")
    genre_count_before_import = Genre.count
    Genre.find_or_create("Jazz")
    genre_count_after_import = Genre.count
    assert_equal genre_count_before_import, genre_count_after_import
  end

  def test_existing_genre_is_returned_by_find_or_create
    genre1 = Genre.find_or_create("Jazz")
    genre2 = Genre.find_or_create("Jazz")
    assert_equal genre1.id, genre2.id, "Genre ids should be identical"
  end

  def test_find_or_create_creates_an_id
    genre = Genre.find_or_create("Funk")
    refute_nil genre.id, "Genre id shouldn't be nil"
  end

  def test_all_returns_all_genres_in_alphabetical_order
    Genre.find_or_create("Jazz")
    Genre.find_or_create("Funk")
    expected = ["Funk", "Jazz"]
    actual = Genre.all.map{ |genre| genre.name }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_genres
    results = Genre.all
    assert_equal [], results
  end
end

require_relative 'helper'
require_relative '../models/genre'

class TestGenre < JuryTest
  def test_genres_are_created
    genre_count_before_import = database.execute("select count(id) from genres")[0][0]
    Genre.create(name: "Rock")
    genre_count_after_import = database.execute("select count(id) from genres")[0][0]
    assert_equal genre_count_before_import + 1, genre_count_after_import
  end

  def test_create_creates_an_id
    genre = Genre.create(name: "Funk")
    refute_nil genre.id, "Genre id shouldn't be nil"
  end

  def test_all_returns_all_genres_in_alphabetical_order
    Genre.create(name: "Jazz")
    Genre.create(name: "Funk")
    expected = ["Funk", "Jazz"]
    actual = Genre.all.map{ |genre| genre.name }
    assert_equal expected, actual
  end

  def test_all_returns_empty_array_if_no_genres
    results = Genre.all
    assert_equal [], results
  end
end

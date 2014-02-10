require_relative 'helper'

class TestSearchingSongs < JuryTest
  def test_search_returns_relevant_results
    genre = Genre.find_or_create_by(name: "Electronic")
    Song.create(name: "Pancake Lizard", artist: "Aphex Twin", genre: genre, intensity: 3, focusing: 0)
    genre = Genre.find_or_create_by(name: "Classical")
    Song.create(name: "Cantus In Memory Of Benjamin Britten", artist: "Arvo Pärt", genre: genre, intensity: 4, focusing: 1)
    genre = Genre.find_or_create_by(name: "Jazz")
    Song.create(name: "Yègellé Tezeta (My Own Memory)", artist: "Mulatu Astatke", genre: genre, intensity: 4, focusing: 1)

    shell_output = ""
    IO.popen('./jury search --environment test', 'r+') do |pipe|
      pipe.puts("Memory")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Cantus In Memory Of Benjamin Britten", "Yègellé Tezeta (My Own Memory)"
  end
end

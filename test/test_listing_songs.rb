require_relative 'helper'

class TestListingSongs < JuryTest
  def test_list_returns_all_results
    genre = Genre.find_or_create("Bluegrass")
    buck_dance = Song.create(name: "Buck Dance", artist: "Hobart Smith", genre: genre, intensity: 3, focusing: 1)
    genre = Genre.find_or_create("Hip Hop")
    finally_back = Song.create(name: "Finally Back", artist: "Lazerbeak", genre: genre, intensity: 5, focusing: 1)
    genre = Genre.find_or_create("Electronic")
    the_white_hole = Song.create(name: "The White Hole", artist: "Knodel", genre: genre, intensity: 3, focusing: 1)

    command_output = `./jury list --environment test`
    assert_includes_in_order command_output,
      "Songs in the database:",
      "\"Buck Dance\" by Hobart Smith, Bluegrass, intensity: 3, focusing value: 1, id: #{buck_dance.id}",
      "\"Finally Back\" by Lazerbeak, Hip Hop, intensity: 5, focusing value: 1, id: #{finally_back.id}",
      "\"The White Hole\" by Knodel, Electronic, intensity: 3, focusing value: 1, id: #{the_white_hole.id}"
  end
end

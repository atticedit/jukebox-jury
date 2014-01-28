require_relative 'helper'

class TestListingSongs < JuryTest

  def test_list_returns_all_results
    buck_dance = Song.create(name: "Buck Dance", artist: "Hobart Smith", genre: "Bluegrass", intensity: 3, focusing: 1)
    finally_back = Song.create(name: "Finally Back", artist: "Lazerbeak", genre: "Hip Hop", intensity: 5, focusing: 1)
    the_white_hole = Song.create(name: "The White Hole", artist: "Knodel", genre: "Electronic", intensity: 3, focusing: 1)

    command = "./jury list"
    expected = <<EOS.chomp
Songs in the database:
'Buck Dance' by Hobart Smith, Bluegrass, intensity: 3, focusing value: 1, id: #{buck_dance.id}
'Finally Back' by Lazerbeak, Hip Hop, intensity: 5, focusing value: 1, id: #{finally_back.id}
'The White Hole' by Knodel, Electronic, intensity: 3, focusing value: 1, id: #{the_white_hole.id}
EOS
    assert_command_output expected, command
  end

end

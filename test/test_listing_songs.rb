require_relative 'helper'

class TestListingSongs < JuryTest

  def test_list_returns_all_results
    `./jury add 'Crusoe' --artist 'The Ex & Tom Cora' --genre Punk --intensity 4 --focusing 1 --environment test`
    `./jury add 'Buck Dance' --artist 'Hobart Smith' --genre Bluegrass --intensity 3 --focusing 1 --environment test`
    `./jury add 'The White Hole' --artist 'Knodel' --genre Electronic --intensity 3 --focusing 1 --environment test`

    command = "./jury list"
    expected = <<EOS.chomp
Songs in the database:
'Crusoe' by The Ex & Tom Cora, Punk, intensity: 4, focusing value: 1
'Buck Dance' by Hobart Smith, Bluegrass, intensity: 3, focusing value: 1
'The White Hole' by Knodel, Electronic, intensity: 3, focusing value: 1
EOS
    assert_command_output expected, command
  end

end

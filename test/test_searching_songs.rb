require_relative 'helper'

class TestSearchingSongs < JuryTest
  def test_search_returns_relevant_results
    `./jury add 'Pancake Lizard' --artist 'Aphex Twin' --genre Electronic --intensity 3 --focusing 0 --environment test`
    `./jury add 'Cantus In Memory Of Benjamin Britten' --artist 'Arvo Pärt' --genre Classical --intensity 4 --focusing 1 --environment test`
    `./jury add 'Yègellé Tezeta (My Own Memory)' --artist 'Mulatu Astatke' --genre Ethiopian Jazz --intensity 4 --focusing 1 --environment test`

    shell_output = ""
    IO.popen('./jury search --environment test', 'r+') do |pipe|
      pipe.puts("Memory")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_in_output shell_output, "Cantus In Memory Of Benjamin Britten", "Yègellé Tezeta (My Own Memory)"
  end

  def test_search_doesnt_return_irrelevant_results
    `./jury add 'Pancake Lizard' --artist 'Aphex Twin' --genre Electronic --intensity 3 --focusing 0 --environment test`
    `./jury add 'Cantus In Memory Of Benjamin Britten' --artist 'Arvo Pärt' --genre Classical --intensity 4 --focusing 1 --environment test`
    `./jury add 'Yègellé Tezeta (My Own Memory)' --artist 'Mulatu Astatke' --genre Ethiopian Jazz --intensity 4 --focusing 1 --environment test`

    shell_output = ""
    IO.popen('./jury search --environment test', 'r+') do |pipe|
      pipe.puts("Memory")
      pipe.close_write
      shell_output = pipe.read
    end
    assert_not_in_output shell_output, "Pancake Lizard"
  end
end

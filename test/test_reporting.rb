require_relative 'helper'
require_relative '../lib/importer'

class TestReporting < JuryTest
  def import_data
    Importer.import("test/sample_song_data_2.csv")
  end

  def test_user_is_asked_for_guesses
    shell_output = ""
    IO.popen("./jury report --environment test", 'r+') do |pipe|
      pipe.puts "Y"
      pipe.puts "Classical with an intensity level of 3"
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output,
      "I can analyze the types of songs you marked as best for concentration."
      "My report will show the combinations of genre and intensity you concentrate to best."
      "Before I start, do you have any guesses?"
      "Enter 'Y' for yes or 'N' for no, then hit return."
      "What do you think is your best combination of genre and intensity for concentration?"
      "That's an interesting guess. Let's see if you're right."
      "[dramatic pause]"
      "You concentrate best to these types of music:"
  end

  def test_user_enters_bad_input_for_having_a_guess
    shell_output = ""
    IO.popen("./jury report --environment test", 'r+') do |pipe|
      pipe.puts "X"
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output,
      "Since I was looking for 'Y' or 'N', I'll take that as a no."
      "I'll just tell you."
      "[dramatic pause]"
      "You concentrate best to these types of music:"
  end

  def test_user_doesnt_have_a_guess
    import_data
    shell_output = ""
    IO.popen("./jury report --environment test", 'r+') do |pipe|
      pipe.puts "N"
      shell_output = pipe.read
    end
    assert_includes_in_order shell_output,
      "In that case, I'll just tell you."
      "[dramatic pause]"
      "You concentrate best to these types of music:"
      "Jazz with an intensity level of 4    -----    you currently have 5 of this combination"
      "Electronic with an intensity level of 3    -----    you currently have 4 of this combination"
      "Punk with an intensity level of 4    -----    you currently have 3 of this combination"
  end
end

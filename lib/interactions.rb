module Interactions
  def ask(question)
    puts question
    return $stdin.gets.chomp
  end

  def tell(statement)
    puts statement
  end
end

class Genre
  attr_accessor :name
  attr_reader :id

  def self.default
    @@default ||= Genre.find_or_create("Unclassified")
  end

  def initialize(name)
    self.name = name
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from genres order by name ASC")
    results.map do |row_hash|
      genre = Genre.new(row_hash["name"])
      genre.send("id=", row_hash["id"])
      genre
    end
  end

  def self.find_or_create name
    database = Environment.database_connection
    database.results_as_hash = true
    genre = Genre.new(name)
    results = database.execute("select * from genres where name = '#{genre.name}'")
    if results.empty?
      database.execute("insert into genres(name) values('#{name}')")
      genre.send("id=", database.last_insert_row_id)
    else
      row_hash = results[0]
      genre.send("id=", row_hash["id"])
    end
    genre
  end

  protected

  def id=(id)
    @id = id
  end
end

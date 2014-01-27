class Song
  attr_accessor :name, :artist, :genre, :intensity, :focusing

  def initialize attributes = {}
    [:name, :artist, :genre, :intensity, :focusing].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def save
    database = Environment.database_connection
    # Should be rewritten to prevent SQL injection attack:
    database.execute("insert into songs(name, artist, genre, ) values('#{name}', #{artist}, #{genre}, #{intensity}, #{focusing})")
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from songs order by name ASC")
    results.map do |row_hash|
      Song.new(name: row_hash["name"], artist: row_hash["artist"], genre: row_hash["genre"], intensity: row_hash["intensity"], focusing: row_hash["focusing"])
    end
  end

  def to_s
    "\'#{name}\' by #{artist}, #{genre}, intensity: #{intensity}, focusing value: #{focusing}"
  end
end

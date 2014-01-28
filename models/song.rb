class Song
  attr_accessor :name, :artist, :genre, :intensity, :focusing
  attr_reader :id

  def initialize attributes = {}
    [:name, :artist, :genre, :intensity, :focusing].each do |attr|
      self.send("#{attr}=", attributes[attr])
    end
  end

  def self.create(attributes = {})
    song = Song.new(attributes)
    song.save
    song
  end

  def save
    database = Environment.database_connection
    # Should be rewritten to prevent SQL injection attack:
    database.execute("insert into songs(name, artist, genre, intensity, focusing) values('#{name}', '#{artist}', '#{genre}', #{intensity}, #{focusing})")
    @id = database.last_insert_row_id
  end

  def self.all
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from songs order by name ASC")
    results.map do |row_hash|
      song = Song.new(name: row_hash["name"], artist: row_hash["artist"], genre: row_hash["genre"], intensity: row_hash["intensity"], focusing: row_hash["focusing"])
      song.send("id=", row_hash["id"])
      song
    end
  end

  def to_s
    "\'#{name}\' by #{artist}, #{genre}, intensity: #{intensity}, focusing value: #{focusing}, id: #{id}"
  end

  protected

  def id=(id)
    @id = id
  end
end

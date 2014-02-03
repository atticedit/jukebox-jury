class Song
  attr_accessor :name, :artist, :genre, :intensity, :focusing
  attr_reader :id

  def initialize attributes = {}
    update_attributes(attributes)
    self.genre ||= Genre.default
  end

  def intensity=(intensity)
    @intensity = intensity.to_i
  end

  def focusing=(focusing)
    @focusing = focusing.to_i
  end

  def self.create(attributes = {})
    song = Song.new(attributes)
    song.save
    song
  end

  def update(attributes = {})
    update_attributes(attributes)
    save
  end

  def save
    database = Environment.database_connection
    genre_id = genre.nil? ? "NULL" : genre.id
    # Ideally this would be rewritten to prevent SQL injection attack:
    if id
      database.execute("update songs set name = '#{name}', artist = '#{artist}', genre_id = #{genre_id}, intensity = #{intensity}, focusing = #{focusing} where id = #{id}")
    else
      save_sql = "insert into songs(name, artist, genre_id, intensity, focusing)
                  values(?, ?, ?, ?, ?)"
      sql_statement = database.prepare(save_sql)
      sql_statement.execute(@name, @artist, genre.id, @intensity, @focusing)
      @id = database.last_insert_row_id
    end
  end

  def self.find id
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select * from songs where id = #{id}")[0]
    if results
      song = Song.new(name: results["name"], artist: results["artist"], intensity: results["intensity"], focusing: results["focusing"])
      genre = Genre.all.find{|genre| genre.id == results["genre_id"]}
      song.genre = genre
      song.send("id=", results["id"])
      song
    else
      nil
    end
  end

  def self.all
    search
  end

  def self.search(search_term = nil)
    database = Environment.database_connection
    database.results_as_hash = true
    results = database.execute("select songs.* from songs where name LIKE '%#{search_term}%' order by name ASC")
    results.map do |row_hash|
      song = Song.new(
             name: row_hash["name"],
             artist: row_hash["artist"],
             intensity: row_hash["intensity"],
             focusing: row_hash["focusing"])
      genre = Genre.all.find{|genre| genre.id == row_hash["genre_id"]}
      song.genre = genre
      song.send("id=", row_hash["id"])
      song
    end
  end

  def to_s
    "\'#{name}\' by #{artist}, #{genre.name}, intensity: #{intensity}, focusing value: #{focusing}, id: #{id}"
  end

  def ==(other)
    other.is_a?(Song) && self.to_s == other.to_s
  end

  protected

  def id=(id)
    @id = id
  end

  def update_attributes(attributes)
    [:name, :artist, :genre, :intensity, :focusing].each do |attr|
      if attributes[attr]
        self.send("#{attr}=", attributes[attr])
      end
    end
  end
end

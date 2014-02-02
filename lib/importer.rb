require 'csv'

class Importer
  def self.import(from_filename)
    CSV.foreach(from_filename, headers: true) do |row_hash|
      import_song(row_hash)
    end
  end

  def self.import_song(row_hash)
    genre = Genre.find_or_create(row_hash["genre"])
    song = Song.create(
      name: row_hash["name"],
      artist: row_hash["artist"],
      genre: genre,
      intensity: row_hash["intensity"].to_i,
      focusing: row_hash["focusing"].to_i
    )
  end
end

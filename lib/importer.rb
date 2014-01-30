require 'csv'

class Importer
  def self.import(from_filename)
    CSV.foreach(from_filename, headers: true) do |row_hash|
      import_song(row_hash)
      Genre.find_or_create(row_hash["genre"])
    end
  end

  def self.import_song(row_hash)
    song = Song.create(
      name: row_hash["name"],
      artist: row_hash["artist"],
      intensity: row_hash["intensity"].to_i,
      focusing: row_hash["focusing"].to_i
    )
  end
end

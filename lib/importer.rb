require 'csv'

class Importer
  def self.import(from_filename)
    CSV.foreach(from_filename, headers: true) do |row_hash|
      song = Song.create(
        name: row_hash["name"],
        artist: row_hash["artist"],
        genre: row_hash["genre"],
        intensity: row_hash["intensity"].to_i,
        focusing: row_hash["focusing"].to_i
      )
    end
  end
end

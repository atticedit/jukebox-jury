class Song < ActiveRecord::Base
  belongs_to :genre

  default_scope { order("name ASC") }

  before_create :set_default_genre

  def self.search(search_term = nil)
    Song.where("name LIKE ?", "%#{search_term}%").to_a
  end

  def to_s
    "\"#{name}\" by #{artist}, #{genre.name}, intensity: #{intensity}, focusing value: #{focusing}, id: #{id}"
  end

  private

  def set_default_genre
    self.genre ||= Genre.default
  end
end

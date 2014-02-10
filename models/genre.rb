class Genre < ActiveRecord::Base
  default_scope { order("name ASC") }

  def self.default
    Genre.find_or_create_by(name: "Unclassified")
  end
end

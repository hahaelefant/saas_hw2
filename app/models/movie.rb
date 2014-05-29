class Movie < ActiveRecord::Base
  attr_accessible :title, :rating, :description, :release_date

  def self.all_ratings
    x = Movie.select(:rating)
    erg = []
    x.each do |y|
      erg.push y.rating unless erg.include? y.rating
    end
    erg
  end
end

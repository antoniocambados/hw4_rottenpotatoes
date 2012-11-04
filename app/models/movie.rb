class Movie < ActiveRecord::Base
  def self.all_ratings
    %w(G PG PG-13 NC-17 R)
  end
  
  def related_movies
    Movie.find_all_by_director(self.director)
  end
end

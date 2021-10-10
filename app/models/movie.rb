class Movie < ActiveRecord::Base
	
	
	def self.all_ratings
		['G', 'PG', 'PG-13', 'R']
	end
	
	def self.with_ratings(ratings)
		if(ratings.length !=0)
		Movie.where(rating: ratings)
		else
			Movie.all
		end
		
	end
end

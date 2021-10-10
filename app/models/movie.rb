class Movie < ActiveRecord::Base
	ratings_to_show =[]
	
	
	
	
	def all_ratings
		@all_ratings = ['G', 'PG', 'PG-13', 'R']
	end
	def with_ratings(ratings)
		if(ratings!=nil)
		movies.where('rating = ?', ratings)
		else
			movies.all
		end
	end
end

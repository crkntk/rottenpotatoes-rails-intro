class Movie < ActiveRecord::Base
	
	
	
		@all_ratings = ['G', 'PG', 'PG-13', 'R']
	
	def with_ratings(ratings)
		if(ratings!=nil)
		movies.where('rating = ?', ratings)
		else
			movies.all
		end
		
	end
end

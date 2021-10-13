class Movie < ActiveRecord::Base
	
	
	def self.all_ratings
		['G', 'PG', 'PG-13', 'R']
	end
	
	
	def self.ordered_ratings
			Movie.order("title ASC")
	end
	
	
	def self.ordered_release
			Movie.order("release_date ASC")
	end
	
	def self.with_ratings(ratings,order)
		if(ratings.length !=0 && order!= nil)
		Movie.where(rating: ratings)
		elsif (ratings.length != 0 && order == "Title")
			Movie.where(rating: ratings).order("title ASC")
			
		elsif(ratings.length !=0 && order!= "Release_Date")
			Movie.where(rating: ratings).order("release_date ASC")
			
		elsif (ratings.length == 0 && order == "Title")
			Movie.order("title ASC")
			
		elsif (ratings.length == 0 && order == "Release_Date")
			Movie.order("release_date ASC")
			
		else
			Movie.all
		end
		
	end
end


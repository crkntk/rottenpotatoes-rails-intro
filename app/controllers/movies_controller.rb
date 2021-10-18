class MoviesController < ApplicationController
	before_filter :set_ratings, :ratings_to_show
  def show
    id = params[:id] # retrieve movie ID from URI route
		
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end
	def set_ratings
		if(@all_ratings == nil)
			@all_ratings = Movie.all_ratings
		else
			return
		end
		end
	
  def index
		@clicked = ""
		if(params[:clicked]== "Title")
			@title_class = "p-3 mb-2 bg-warning text-dark"
			session[:clicked] = params[:clicked]
		end
		if(params[:clicked]== "Release_Date")
			@release_class = "p-3 mb-2 bg-warning text-dark"
			session[:clicked] = params[:clicked]
		end
		if(params[:clicked]== nil && params[:home] != nil)
			session[:clicked] = nil
		end
		if(params[:clicked]== nil && params[:ratings] == nil && session[:redirect] == nil)
			session[:redirect] = true
			if (session[:ratings] != nil && params[:home] == nil)
				params[:ratingskeys] = session[:ratings]
				redirect_to movies_path(clicked: session[:clicked])
				return
			end
			session[:ratings] = nil
			redirect_to movies_path 
		else
			session[:redirect] = nil
    @movies = Movie.with_ratings(params[:ratingskeys],params[:clicked])
		end
	end
	
def ratings_to_show
	
	if(params[:ratings] == nil && session[:ratings] == nil)
		params[:ratingskeys] = []
		@ratings_to_show = []
	elsif(session[:ratings] && params[:ratings] != nil|| (session[:ratings] == nil && params[:ratings] != nil)  )
		session[:ratings] = params[:ratings].keys
		@ratings_to_show = params[:ratings].keys
		params[:ratingskeys] = params[:ratings].keys
	elsif(session[:ratings])
		params[:ratingskeys] = session[:ratings]
		@ratings_to_show = session[:ratings]
	end
		
end
	
	
  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(movie_params)
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

  private
  # Making "internal" methods private is not required, but is a common practice.
  # This helps make clear which methods respond to requests, and which ones do not.
  def movie_params
    params.require(:movie).permit(:title, :rating, :description, :release_date)
  end
end

class MoviesController < ApplicationController

  def show
    id = params[:id] # retrieve movie ID from URI route
    @movie = Movie.find(id) # look up movie by unique ID
    # will render app/views/movies/show.<extension> by default
  end

  def index
    if params[:sortBy] == "title"
      @movies = Movie.find(:all, :order => "title")
      @title = true
      session[:sortBy] = "title"
    elsif params[:sortBy] == "release"
      @movies = Movie.find(:all, :order => "release_date") 
      @release = true
      session[:sortBy] = "release"
    elsif session[:sortBy] == "release"
      @movies = Movie.find(:all, :order => "release_date") 
      @release = true
    elsif session[:sortBy] == "release"
      @movies = Movie.find(:all, :order => "release_date") 
      @release = true
    else
      @movies = Movie.all 
    end
    @all_ratings = Movie.all_ratings
    if params[:ratings] != nil
      @movies = @movies.select{ |x| params[:ratings].include? x.rating }
      @checked = params[:ratings].keys
      session[:checked] = @checked
    elsif session[:checked] != nil
      @checked = session[:checked]
      @movies = @movies.select{ |x| @checked.include? x.rating }
    else
      @checked = Movie.all_ratings
    end
  end

  def new
    # default: render 'new' template
  end

  def create
    @movie = Movie.create!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully created."
    redirect_to movies_path
  end

  def edit
    @movie = Movie.find params[:id]
  end

  def update
    @movie = Movie.find params[:id]
    @movie.update_attributes!(params[:movie])
    flash[:notice] = "#{@movie.title} was successfully updated."
    redirect_to movie_path(@movie)
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    flash[:notice] = "Movie '#{@movie.title}' deleted."
    redirect_to movies_path
  end

end

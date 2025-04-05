class MoviesController < ApplicationController
  def new
    @movie = Movie.new

    # render template: "movies/new"
    # render "movies/new" -- if the controller name is matching the view folder and the action is matching with the view file name.
  end

  def index
    @movies = Movie.order({ created_at: :desc })

    respond_to do |format|
      format.json do
        render json: @movies
      end

      format.html
      # format.html do
      #   render template: "movies/index" 
      # end
    end
  end

  def show
    @movie  = Movie.find(params.fetch(:id))
    # render template: "movies/show" 
     # render "movies/show" 
  end

  def create
    @movie = Movie.new
    @movie.title = params.fetch(:movie).fetch(:title)
    @movie.description = params.fetch(:movie).fetch(:description)

    if @movie.valid?
      @movie.save
      redirect_to movies_url, notice: "Movie was successfully created." 
    else
      render "new"
      # render template: "movies/new"
    end
  end

  def edit
    @movie  = Movie.find(params.fetch(:id) )

    # render template: "movies/edit"
  end

  def update
    @movie  = Movie.find(params.fetch(:id))

    @movie.title = params.fetch(:title)
    @movie.description = params.fetch(:description)

    if @movie.valid?
      @movie.save
      redirect_to movie_url(@movie.id),  notice: "Movie updated successfully." 
    else
      redirect_to movie_url(@movie.id), alert: "Movie failed to update successfully." 
    end
  end

  def destroy
    @movie  = Movie.find(params.fetch(:id))

    @movie.destroy

    redirect_to movies_url, notice: "Movie deleted successfully."
  end
end

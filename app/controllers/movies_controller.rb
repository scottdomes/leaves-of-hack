class MoviesController < ApplicationController
  def index
    if params
      @movies = Movie.where("title like ? OR director like ?", "%#{params[:query]}%", "%#{params[:query]}%").page(params[:page])
      if params[:search_runtime]
        case params[:search_runtime]
        when "1"
          @movies = @movies.short
        when "2"
          @movies = @movies.medium
        when "3"
          @movies = @movies.long
        end
      end
    else
      @movies = Movie.all.page(params[:page])
    end
  end

  def show
    @movie = Movie.find(params[:id])
  end

  def new
    @movie = Movie.new
  end
  
  def create
    @movie = Movie.new(movie_params)

    if @movie.save
      redirect_to movies_path, notice: "#{@movie.title} was submitted successfully!"
    else
      render :new
    end
  end

  def edit
    @movie = Movie.find(params[:id])
  end

  def update
    @movie = Movie.find(params[:id])

    if @movie.update_attributes(movie_params)
      redirect_to movie_path(@movie)
    else
      render :edit
    end
  end

  def destroy
    @movie = Movie.find(params[:id])
    @movie.destroy
    redirect_to movies_path
  end

  protected

  def movie_params
    params.require(:movie).permit(
      :title, :release_date, :director, :runtime_in_minutes, :poster_image_url, :description, :image
      )
  end
end

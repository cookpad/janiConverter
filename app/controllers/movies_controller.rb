class MoviesController < ApplicationController
  respond_to :json, :html

  def new
    @movie = Movie.new(uuid: SecureRandom.uuid)
  end

  def create
    @movie = Movie.create(movie_params(params))
    Converter.perform_async(@movie.uuid)
    redirect_to @movie
  end

  def show
    @movie = Movie.where(id: params[:id]).first()
    respond_with @movie
  end

  private

  def movie_params(params)
    params.require(:movie).permit(:uuid, :fps, :frame_height, :frame_width, :movie, :movie_cache)
  end
end

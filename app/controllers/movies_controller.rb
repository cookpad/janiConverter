class MoviesController < ApplicationController
  respond_to :json, :html

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create(movie_params(params).merge(uuid: SecureRandom.uuid))
    Converter.perform_async(@movie.uuid)
    redirect_to @movie
  end

  def show
    @movie = Movie.where(id: params[:id]).first()
    respond_with @movie
  end

  private

  def movie_params(params)
    params.require(:movie).permit(:fps, :frame_height, :frame_width, :movie, :movie_cache)
  end
end

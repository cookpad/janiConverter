class MoviesController < ApplicationController
  respond_to :json, :html

  def create
    Movie.create()
    redirect_to "show"
  end

  def show
    @movie = Movie.where(id: params[:id]).first()
    respond_with @movie
  end
end

class MoviesController < ApplicationController
  respond_to :json, :html

  def new
    @movie = Movie.new
  end

  def create
    @movie = Movie.create(movie_params(params).merge(uuid: SecureRandom.uuid))
    create_tracking_events_if_params_available(@movie, params)
    Converter.perform_async(@movie.uuid)
    redirect_to @movie
  end

  def show
    @movie = Movie.where(id: params[:id]).first()
    respond_with @movie
  end

  private

  def movie_params(params)
    params.require(:movie).permit(:fps, :frame_height, :frame_width, :movie, :movie_cache, :tracking_events)
  end

  def create_tracking_events_if_params_available(movie, params)
    tracking_events_params = params[Movie.class_name.underscore][TrackingEvent.class_name.pluralize.underscore]
    return unless tracking_events_params
    tracking_events_params.each do |event_name, parameters|
      @movie.tracking_events.build.tap do |tracking_event|
        tracking_event.label = parameters["label"]
        tracking_event.url = parameters["url"]
        tracking_event.save
      end
    end
  end
end

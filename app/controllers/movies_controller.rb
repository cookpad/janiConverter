class MoviesController < ApplicationController
  respond_to :json, :html

  MOVIES_PER_PAGE = 9

  def new
    @movie = Movie.new.tap{ |m| m.pixel_ratio = nil }
    @loading_banner = @movie.build_loading_banner
    @postroll_banner = @movie.build_postroll_banner
  end

  def create
    @movie = Movie.new(movie_params(params).merge(uuid: SecureRandom.uuid))
    build_banners_if_available(@movie)
    @movie.save!
    create_tracking_events_if_params_available(@movie, params)

    Converter.perform_async(@movie.uuid, params[:callback_url])

    respond_to do |format|
      format.json { respond_with @movie }
      format.html { redirect_to movies_path }
    end
  end

  def show
    @movie = if params[:uuid]
      Movie.where(uuid: params[:uuid]).first()
    else
      Movie.where(id: params[:id]).first()
    end

    return head :not_found unless @movie
    respond_with @movie
  end

  def index
    @movies = Movie.valid.order(created_at: :desc).preload(:loading_banner).page(params[:page]).per(MOVIES_PER_PAGE)
  end

  private

  def movie_params(params)
    params.require(:movie).permit(
      :fps,
      :frame_height,
      :frame_width,
      :movie,
      :movie_cache,
      :remote_movie_url,
      :pixel_ratio,
      :vast_url,
      postroll_banner_attributes: [:url, :image, :remote_image_url],
      loading_banner_attributes: [:image, :remote_image_url]
    )
  end

  def create_tracking_events_if_params_available(movie, params)
    tracking_events_params = params[Movie.name.underscore][TrackingEvent.name.pluralize.underscore]
    return unless tracking_events_params
    tracking_events_params.each do |event_name, parameters|
      return if parameters["url"].empty?
      @movie.tracking_events.build.tap do |tracking_event|
        tracking_event.label = parameters["label"]
        tracking_event.url = parameters["url"]
        tracking_event.request_type = parameters["request_type"] || TrackingEvent::DEFAULT_REQUEST_TYPE
        tracking_event.save
      end
    end
  end

  def build_banners_if_available(movie)
    if movie.loading_banner
      movie.loading_banner.movie = movie
    end

    if movie.postroll_banner
      movie.postroll_banner.movie = movie
    end
  end
end

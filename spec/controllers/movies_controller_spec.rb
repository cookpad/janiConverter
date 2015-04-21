require 'rails_helper'
require 'sidekiq/testing'

describe MoviesController, type: :controller do
  before { Sidekiq::Testing.fake! }
  after { Sidekiq::Worker.clear_all }

  describe "#create" do
    subject { post :create, movie: movie_params }

    let(:movie_params) { new_movie.attributes }
    let(:new_movie) { build(:movie) }

    it "creates a movie" do
      expect{ subject }.to change{ Movie.count(1) }.by(1)
    end

    it "sets attributes: uuid, fps, frame_height, frame_width, pixel_ratio, vast_url" do
      subject
      expect(assigns(:movie).uuid).not_to eq(new_movie.uuid)
      expect(assigns(:movie).fps).to eq(new_movie.fps)
      expect(assigns(:movie).frame_height).to eq(new_movie.frame_height)
      expect(assigns(:movie).frame_width).to eq(new_movie.frame_width)
      expect(assigns(:movie).pixel_ratio).to eq(new_movie.pixel_ratio)
      expect(assigns(:movie).vast_url).to eq(new_movie.vast_url)
    end

    it "sets MovieUploader instance to Movie model instance" do
      subject
      expect(assigns(:movie).movie).to be_a_kind_of(MovieUploader)
    end

    describe "tracking events attributes" do
      let(:movie_params) do
        new_movie.attributes.merge(
          "tracking_events" => {
            "creative_view" => {"label"=>"creative_view", "url"=>"/track?event=creative_view"},
            "start"=>{"label"=>"start", "url"=>"/track?event=start", "request_type"=>"xhr"},
            "first_quartile"=>{"label"=>"first_quartile", "url"=>""},
            "mid_point"=>{"label"=>"mid_point", "url"=>""},
          }
        )
      end

      it "creates tracking events" do
        subject
        expect(assigns(:movie).tracking_events.count).to eq 2
        expect(assigns(:movie).tracking_events.first.label).to eq "creative_view"
        expect(assigns(:movie).tracking_events.first.url).to eq "/track?event=creative_view"
        expect(assigns(:movie).tracking_events.first).to be_img
        expect(assigns(:movie).tracking_events.second.label).to eq "start"
        expect(assigns(:movie).tracking_events.second.url).to eq "/track?event=start"
        expect(assigns(:movie).tracking_events.second).to be_xhr
      end
    end

    describe "banner attributes" do
      let(:postroll_banner) { build(:postroll_banner) }
      let(:loading_banner) { build(:loading_banner) }
      let(:movie_params) do
        new_movie.attributes.merge(
          postroll_banner_attributes: postroll_banner.attributes,
          loading_banner_attributes: loading_banner.attributes,
        )
      end

      it "creates postroll banner" do
        expect{ subject }.to change{ Movie.count(1) }.by(1)
      end

      it "creates postroll banner" do
        expect{ subject }.to change{ PostrollBanner.count(1) }.by(1)
      end

      it "creates loading banner" do
        expect{ subject }.to change{ LoadingBanner.count(1) }.by(1)
      end

      it "sets banners attributes" do
        subject
        postroll_banner = assigns(:movie).postroll_banner
        expect(postroll_banner).not_to be_nil
        expect(postroll_banner.url).to eq postroll_banner.url
        expect(postroll_banner.image.model).to eq postroll_banner
        expect(postroll_banner.movie).to eq assigns(:movie)

        loading_banner = assigns(:movie).loading_banner
        expect(loading_banner).not_to be_nil
        expect(loading_banner.image.model).to eq loading_banner
        expect(loading_banner.movie).to eq assigns(:movie)
      end
    end
  end

  describe "#show" do
    subject { get :show, id: movie.id, format: :json }

    let(:movie)  { create(:movie) }
    let(:strips_count) { rand(10) + 1 }
    let(:response_movie) { JSON.parse(response.body).with_indifferent_access }

    before { strips_count.times { create(:strip, movie: movie) } }

    it "shows the movie" do
      subject
      expect(assigns(:movie).uuid).to eq(movie.uuid)
      expect(response_movie[:uuid]).to eq(movie.uuid)
      expect(assigns(:movie).strips).to have(strips_count).items
      expect(response_movie[:strips]).to have(strips_count).items
    end
  end
end

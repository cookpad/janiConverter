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

    it "sets attributes: uuid, fps, frame_height, frame_width" do
      subject
      expect(assigns(:movie).uuid).not_to eq(new_movie.uuid)
      expect(assigns(:movie).fps).to eq(new_movie.fps)
      expect(assigns(:movie).frame_height).to eq(new_movie.frame_height)
      expect(assigns(:movie).frame_width).to eq(new_movie.frame_width)
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
            "start"=>{"label"=>"start", "url"=>"/track?event=start"},
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
        expect(assigns(:movie).tracking_events.second.label).to eq "start"
        expect(assigns(:movie).tracking_events.second.url).to eq "/track?event=start"
      end
    end
  end

  describe "#show" do
    subject { get :show, id: movie.id, format: :json }

    let(:movie)  { create(:movie) }

    it "shows the movie" do
      subject
      expect(assigns(:movie).uuid).to eq(movie.uuid)
    end
  end
end

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

require 'rails_helper'

describe MoviesController, type: :controller do
  describe "create" do
    subject { post :create }

    it "creates a movie" do
      expect{ subject }.to change{ Movie.count(1) }.by(1)
    end
  end

  describe "show" do
    let(:movie)  { create(:movie) }
    subject { get :show, id: movie.id, format: :json  }

    it "shows the movie" do
      subject
      expect(assigns(:movie).id).to eq(movie.id)
    end
  end
end

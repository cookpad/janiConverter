require 'rails_helper'

describe MovieUploader do
  describe "#url" do
    subject { movie_uploader.url }

    let(:movie_uploader) { MovieUploader.new }
    let(:movie_file) { File.open("spec/fixtures/movies/kuro.mov") }
    let(:store_dir) { "uploads/test/movies" }

    before do
      allow(movie_uploader).to receive_messages(store_dir: store_dir)
      movie_uploader.store!(movie_file)
    end

    context "when not cached" do
      it "returns stored file url" do
        expect(movie_uploader.url).to include(store_dir)
        expect(movie_uploader.path).to include(store_dir)
      end
    end

    context "when cached" do
      before { movie_uploader.cache! }

      it "returns cached file url" do
        expect(movie_uploader.url).not_to include(store_dir)
        expect(movie_uploader.path).not_to include(store_dir)
      end
    end
  end
end

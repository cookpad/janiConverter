require 'rails_helper'

describe Movie, type: :model do
  let(:movie) { create(:movie) }
  describe "#to_strips" do
    it "returns array of Strip" do
      expect(movie.to_strips[0]).to be_a_kind_of(Jani::StripMaker::Strip)
    end
  end
end

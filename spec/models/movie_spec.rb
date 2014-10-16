require 'rails_helper'

describe Movie, type: :model do
  let(:movie) { create(:movie) }
  describe "#to_strips" do
    subject { movie.to_strips.each(&:save)[0] }
    it "returns array of Strip" do
      is_expected.to be_a_kind_of(Strip)
      is_expected.not_to be_a_new_record
      expect(movie.strips).not_to be_empty
    end
  end
end

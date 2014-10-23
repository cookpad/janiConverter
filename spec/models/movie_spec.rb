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

  describe "tracking_event_for_label" do
    subject { movie.tracking_event_for_label(label) }
    let(:label) { tracking_event.label }
    let!(:tracking_event) { create(:tracking_event, movie: movie) }

    context "when nil given for label" do
      let(:label) { nil }

      it "returns nil" do
        is_expected.to be_nil
      end
    end

    it "returns the tracking event" do
      is_expected.to eq tracking_event
    end
  end
end

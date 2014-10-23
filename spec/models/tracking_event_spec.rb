require 'rails_helper'

RSpec.describe TrackingEvent, :type => :model do
  let(:movie) { create(:movie) }
  let(:new_tracking_events) { build(:tracking_event, movie: movie) }

  describe "unique validation" do
    context "when try to create tracking event with same label to a movie" do
      before do
        new_tracking_events.save!
      end

      it "raises error" do
        expect{ movie.beacons.create!(new_tracking_events.attributes) }.to raise_error
      end
    end
  end

  describe ".for_label" do
    subject { TrackingEvent.for_label(tracking_event.label) }
    let!(:tracking_event) { create(:tracking_event, movie: movie) }

    it "returns the beacon" do
      is_expected.to eq tracking_event
    end
  end
end

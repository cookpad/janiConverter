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

  describe "#to_html" do
    subject(:rendered) { Capybara.string(movie.to_html) }
    let(:movie_element) { rendered.find(".movie") }
    let(:strip_elements) { rendered.all(".strip") }

    it "renders dom for janiplayer" do
      expect(rendered.all(".stages_container")).to have(1).item
    end

    it "sets movie metadatas" do
      expect(movie_element["data-fps"]).to eq movie.fps.to_s
      expect(movie_element["data-frame-height"]).to eq movie.display_height.to_s
      expect(movie_element["data-frame-width"]).to eq movie.display_width.to_s
    end

    context "when no strips given" do
      it "renders no strips" do
        expect(strip_elements).to be_empty
      end
    end

    context "when strips given" do
      let!(:strips) { strips_count.times{ create(:strip, movie: movie) } }
      let(:strips_count) { rand(5) + 1 }

      it "renders strips" do
        expect(strip_elements).to have(strips_count).items
      end
    end
  end
end

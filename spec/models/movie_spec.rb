require 'rails_helper'
require "sidekiq/testing"

describe Movie, type: :model do
  let(:movie) { create(:movie) }

  describe "conversion status" do
    subject { movie }
    context "by default" do
      it "is to_be_converted" do
        is_expected.to be_to_be_converted
      end
    end

    context "after success converted" do
      before do
        allow_any_instance_of(Movie).to(
          receive(:to_strips) { [create(:strip, movie: movie)] }
        )
      end

      it "is converted" do
        expect {
          Converter.new.perform(subject.uuid)
          subject.reload
        }.to change(subject, :converted?).to(true)
      end
    end

    context "after error(empty) converted" do
      before do
        allow_any_instance_of(Movie).to(
          receive(:to_strips) { [] }
        )
      end

      it "is converted" do
        expect {
          Converter.new.perform(subject.uuid)
          subject.reload
        }.to change(subject, :error?).to(true)
      end
    end
  end

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

  describe "JSON serialization" do
    subject do
      JSON.parse(
        MovieSerializer.new(movie).to_json
      ).with_indifferent_access
    end

    before do
      create(:strip, movie: movie)
      create(:tracking_event, movie: movie)
      create(:loading_banner, movie: movie)
      create(:postroll_banner, movie: movie)
    end

    it "has movie attributes and ones of related objects" do
      expect(subject[:uuid]).to eq movie.uuid
      expect(subject[:frame_width]).to eq movie.frame_width
      expect(subject[:frame_height]).to eq movie.frame_height
      expect(subject[:fps]).to eq movie.fps
      expect(subject[:source_url]).to eq movie.movie.url
      expect(subject[:pixel_ratio]).to eq Movie::PIXEL_RATIO
      expect(subject[:loading_banner][:image_url]).to eq movie.loading_banner.image.url
      expect(subject[:postroll_banner][:image_url]).to eq movie.postroll_banner.image.url
      expect(subject[:strips]).to have(1).items
      expect(subject[:strips][0][:image_url]).to eq movie.strips.first.image.url
      expect(subject[:tracking_events]).to have(1).items
    end
  end
end

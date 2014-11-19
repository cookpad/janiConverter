require "rails_helper"

RSpec.describe Preview, type: :model do
  let(:movie) { create(:movie) }
  let(:strip) { create(:strip, movie: movie) }
  let(:preview) { create(:preview, movie: movie) }

  describe "#to_html" do
    subject { preview.to_html }

    context "when the movie is converted" do
      let(:rendered) { Capybara.string(subject) }

      before do
        movie.converted!
        movie.strips << strip
      end

      it "uses preview layout by default" do
        expect(rendered.find("body")["class"]).to eq "preview"
      end

      context "when nil given for layout" do
        subject { preview.to_html(layout: nil) }

        it "does not use any layout" do
          # when capybara parses subject, it automatically adds body tag
          expect(subject).not_to include "<body"
          expect(subject).not_to include "</body"
        end
      end

      it "has strip rendered" do
        expect(rendered.all(".strip", visible: false)).to have(
            movie.strips.count
          ).items
      end

      it "has style tag rendered" do
        expect(rendered.all("style", visible: false)).to be_present
      end

      it "has script tag rendered" do
        expect(rendered.all("script", visible: false)).to be_present
      end
    end

    context "when the movie is converted" do
      it { is_expected.to be_empty }
    end
  end
end

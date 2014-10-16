require "rails_helper"
require "sidekiq/testing"

describe Converter do
  subject do
    Sidekiq::Testing.inline! do
      Converter.perform_async(uuid)
    end
  end

  let(:movie) { create(:movie) }
  let(:uuid) { movie.uuid }

  after { Sidekiq::Worker.clear_all }

  context "when movie exists for the uuid" do
    it "tyies to transcodes to strips" do
      expect_any_instance_of(Movie).to receive(:to_strips).and_return([])
      subject
    end
  end

  context "when movie does not exist for the uuid" do
    before { movie.destroy }
    it "does not tries to trancode to strips and raises no error" do
      expect_any_instance_of(Movie).not_to receive(:to_strips)
      expect { subject }.not_to raise_error
    end
  end
end

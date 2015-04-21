include ActionDispatch::TestProcess
FactoryGirl.define do
  factory :movie do
    uuid { SecureRandom.uuid }
    frame_width { 160 * (rand(3) + 1) }
    frame_height { frame_width / 16 * 9 }
    fps { rand(10) + 10 }
    movie { fixture_file_upload(Rails.root.join("spec", "fixtures", "movies", "kuro.mov")) }
    pixel_ratio { [1, 2].sample }
    vast_url { Faker::Internet.url("rtb.example.com") + "?url=example.com&duration=#{rand(10) + 10}" }
  end
end

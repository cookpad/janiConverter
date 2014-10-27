FactoryGirl.define do
  factory :postroll_banner do
    url { Faker::Internet.url("example.com") }
    movie nil
    image { fixture_file_upload(Rails.root.join("spec", "fixtures", "banners", "post_roll.png")) }
  end
end

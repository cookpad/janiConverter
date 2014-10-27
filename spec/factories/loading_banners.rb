FactoryGirl.define do
  factory :loading_banner do
    movie nil
    image { fixture_file_upload(Rails.root.join("spec", "fixtures", "banners", "loading.png")) }
  end
end

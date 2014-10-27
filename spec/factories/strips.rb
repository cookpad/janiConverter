# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :strip do
    movie nil
    frames_count { rand(100) + 1 }
    index { rand(10) + 1 }
    image { fixture_file_upload(Rails.root.join("spec", "fixtures", "strips", "320x1800.gif")) }
  end
end

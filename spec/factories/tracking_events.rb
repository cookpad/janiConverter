FactoryGirl.define do
  factory :tracking_event do
    label { Faker::Lorem.word }
    url { Faker::Internet.url("example.com") }
    track_on { rand(100) }
    movie nil
  end
end

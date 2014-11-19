FactoryGirl.define do
  factory :preview do
    movie nil
    html do
      fixture_file_upload(
        Rails.root.join("spec", "fixtures", "preview_htmls", "index.html")
      )
    end
  end
end

class CreatePostrollBanners < ActiveRecord::Migration
  def change
    create_table :postroll_banners do |t|
      t.text :url
      t.string :image
      t.references :movie
      t.index :movie_id, unique: true

      t.timestamps
    end
  end
end

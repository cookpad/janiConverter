class CreateLoadingBanners < ActiveRecord::Migration
  def change
    create_table :loading_banners do |t|
      t.string :image
      t.references :movie
      t.index :movie_id, unique: true

      t.timestamps
    end
  end
end

class AddPixelRatioToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :pixel_ratio, :integer, default: 1, null: false
  end
end

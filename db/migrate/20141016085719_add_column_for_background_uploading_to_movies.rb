class AddColumnForBackgroundUploadingToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :movie_processing, :boolean, null: false, default: false
    add_column :movies, :movie_tmp, :string
  end
end

class AddMovieToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :movie, :string
  end
end

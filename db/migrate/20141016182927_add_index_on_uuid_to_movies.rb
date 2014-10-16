class AddIndexOnUuidToMovies < ActiveRecord::Migration
  def change
    add_index :movies, :uuid, unique: true
  end
end

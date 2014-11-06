class AddConvertingToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :conversion_status, :integer, default: 0, limit: 1, null: false
    add_index :movies, :conversion_status
  end
end

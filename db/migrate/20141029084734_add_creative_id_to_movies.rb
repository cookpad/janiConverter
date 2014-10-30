class AddCreativeIdToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :external_creative_id, :string
    add_index  :movies, [:external_creative_id]
  end
end

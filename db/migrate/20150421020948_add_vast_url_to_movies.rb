class AddVastUrlToMovies < ActiveRecord::Migration
  def change
    add_column :movies, :vast_url, :text, default: nil, null: true
  end
end

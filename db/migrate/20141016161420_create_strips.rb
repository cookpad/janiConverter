class CreateStrips < ActiveRecord::Migration
  def change
    create_table :strips do |t|
      t.references :movie
      t.integer :frames_count
      t.integer :index
      t.string :image
      t.index [:movie_id, :index]

      t.timestamps
    end
  end
end

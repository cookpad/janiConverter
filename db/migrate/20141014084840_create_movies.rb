class CreateMovies < ActiveRecord::Migration
  def change
    create_table :movies do |t|
      t.string :uuid
      t.integer :frame_width
      t.integer :frame_height
      t.integer :fps

      t.timestamps
    end
  end
end

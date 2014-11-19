class CreatePreviews < ActiveRecord::Migration
  def change
    create_table :previews do |t|
      t.references :movie
      t.string :html
      t.index :movie_id, unique: true

      t.timestamps
    end
  end
end

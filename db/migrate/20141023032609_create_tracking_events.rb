class CreateTrackingEvents < ActiveRecord::Migration
  def change
    create_table :tracking_events do |t|
      t.string :label
      t.text :url
      t.integer :track_on
      t.references :movie

      t.index [:movie_id, :label], unique: true

      t.timestamps
    end
  end
end

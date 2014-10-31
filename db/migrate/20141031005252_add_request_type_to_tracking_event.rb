class AddRequestTypeToTrackingEvent < ActiveRecord::Migration
  def change
    add_column :tracking_events, :request_type, :integer, default: 0, limit: 1, null: false
  end
end

class TrackingEventSerializer < ActiveModel::Serializer
  attributes :label, :url, :track_on, :request_type
end

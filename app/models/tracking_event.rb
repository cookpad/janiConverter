class TrackingEvent < ActiveRecord::Base
  belongs_to :movie
  validates_presence_of :label, :url, :movie
  validates_uniqueness_of :label, scope: :movie

  scope :for_label, -> (label) { where(label: label).first() }

  module Labels
    # These labels are tracking events of vast 2.0 standards
    # you dont have to support all of them
    # see  http://www.iab.net/media/file/VAST-2_0-FINAL.pdf
    # if you prefer to read in Japanse, this link would be helpful
    # http://support.brightcove.com/ja/video-cloud/サポートドキュメント/vast-20-xml-コードの構成要素
    CREATIVE_VIEW = "creative_view"
    START = "start"
    FIRST_QUARTILE = "first_quartile"
    MID_POINT = "mid_point"
    THIRD_QUARTILE = "third_quartile"
    COMPLETE = "complete"
    MUTE = "mute"
    UNMUTE = "unmute"
    PAUSE = "pause"
    REWIND = "rewind"
    RESUME = "resume"
    FULLSCREEN = "fullscreen"
    EXPAND = "expand"
    COLLAPSE = "collapse"
    ACCEPT_INVITATION = "accept_invitation"
    CLOSE = "close"
  end
end

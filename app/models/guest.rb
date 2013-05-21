class Guest
  include Mongoid::Document

  field :app, type: String
  field :name, type: String

  validates_uniqueness_of :app, :name
  validates_presence_of :app, :name
  validates_format_of :app, with: /^[a-z][a-z0-9\-]{2,30}[a-z0-9]$/

  has_many :recorders
end

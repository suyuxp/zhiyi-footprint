class Guest
  include Mongoid::Document

  field :app, type: String
  field :name, type: String

  validates_uniqueness_of :app, :name
  validates_presence_of :app, :name
end

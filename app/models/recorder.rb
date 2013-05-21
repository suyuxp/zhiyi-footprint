class Recorder
  include Mongoid::Document

  belongs_to :guest
end

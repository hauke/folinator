class Slideset < ActiveRecord::Base
  belongs_to :lecture
  has_many :slides
end

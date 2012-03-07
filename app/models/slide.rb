# == Schema Information
#
# Table name: slides
#
#  id          :integer         not null, primary key
#  image       :string(255)
#  slideset_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Slide < ActiveRecord::Base
  belongs_to :slideset
  has_many :annotations, dependent: :destroy

  validates :slideset_id, presence: true
  #validates :image, presence: true
  mount_uploader :image, SlideUploader

#TODO: order of slides
end

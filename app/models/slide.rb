# == Schema Information
#
# Table name: slides
#
#  id          :integer         not null, primary key
#  image       :string(255)
#  slideset_id :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  position    :integer
#  title_id    :integer
#

class Slide < ActiveRecord::Base
  belongs_to :slideset
  has_many :annotations, dependent: :destroy
  belongs_to :title, class_name: "Annotation", foreign_key: "title_id"

  acts_as_list :scope => :slideset

  validates :slideset_id, presence: true
  validates :image, presence: true
  mount_uploader :image, SlideUploader
end

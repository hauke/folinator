# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: slides
#
#  id          :integer         not null, primary key
#  image       :string(255)     not null
#  slideset_id :integer         not null
#  deleted     :boolean         default(FALSE), not null
#  number      :integer
#  position    :integer         not null
#  title_id    :integer
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#

class Slide < ActiveRecord::Base

  attr_accessible :image, :slideset, :slideset_id

  belongs_to :slideset
  has_many :annotations, dependent: :destroy
  belongs_to :title, class_name: "Annotation", foreign_key: "title_id"

  acts_as_list :scope => :slideset

  validates :slideset_id, presence: true
  validates :image, presence: true
  mount_uploader :image, SlideUploader
end

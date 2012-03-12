# == Schema Information
#
# Table name: annotations
#
#  id         :integer         not null, primary key
#  annotation :string(255)
#  slide_id   :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class DoubleAnnotation < ActiveModel::Validator
  def validate(record)
    if record.slide && !record.slide.annotations.select{|item| item.annotation == record.annotation && item != record}.empty?
      record.errors[:base] << "Annotation already there"
    end
  end
end

class Annotation < ActiveRecord::Base
  belongs_to :slide
  has_one :slide_title, class_name: "Slide", foreign_key: "title_id"

  validates :slide_id, presence: true
  validates :annotation, presence: true
  validates_with DoubleAnnotation
  
  scope :distincttag, :group => ('annotations.annotation')

  def self.search(search)
    if search
      find(:all, :conditions => ['annotation LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end

# == Schema Information
#
# Table name: annotations
#
#  id             :integer         not null, primary key
#  annotation     :string(255)
#  slide_id       :integer
#  deleted        :boolean
#  last_author_id :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
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
  
  scope :distincttag, :group => ('annotations.annotation'), :conditions => ['deleted = ?', false]

  def self.search(search)
    if search
      find(:all, :conditions => ['annotation LIKE ? AND deleted = ?', "%#{search}%", false])
    else
      find(:all)
    end
  end

  def self.search_by_slideset(search, slideset)
    if search
      find(:all, :include => [:slide], :conditions => ['annotations.annotation LIKE ? AND annotations.deleted = ? AND annotations.slide_id = slides.id AND slides.slideset_id = ?', "%#{search}%", false, slideset.id])
    else
      find(:all)
    end
  end

  def self.search_by_lecture(search, lecture)
    if search
      find(:all, :include => [:slide], :conditions => ['annotations.annotation LIKE ? AND annotations.deleted = ? AND annotations.slide_id = slides.id AND slides.slideset_id IN (SELECT slidesets.id FROM "slidesets" WHERE ( slidesets.lecture_id = ? ))', "%#{search}%", false, lecture.id])
    else
      find(:all)
    end
  end
end

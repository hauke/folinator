# -*- encoding : utf-8 -*-
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

  attr_accessible :annotation, :last_author, :slide_id

  belongs_to :slide
  belongs_to :last_author, class_name: "User"
  has_one :slide_title, class_name: "Slide", foreign_key: "title_id"

  validates :last_author_id, presence: true
  validates :slide_id, presence: true
  validates :annotation, presence: true
  validates_with DoubleAnnotation
  
  scope :distincttag, :group => ('annotations.annotation'), :conditions => ['deleted = ?', false]

  def self.search(search)
    find(:all, :conditions => ['annotation LIKE ? AND deleted = ?', "%#{search}%", false])
  end

  def self.search_by_slideset(search, slideset)
   find(:all, :include => [:slide], :conditions => ['annotations.annotation LIKE ? AND annotations.deleted = ? AND annotations.slide_id = slides.id AND slides.slideset_id = ?', "%#{search}%", false, slideset.id])
  end

  def self.search_by_lecture(search, lecture)
    find(:all, :include => [:slide], :conditions => ['annotations.annotation LIKE ? AND annotations.deleted = ? AND annotations.slide_id = slides.id AND slides.slideset_id IN (SELECT slidesets.id FROM slidesets WHERE ( slidesets.lecture_id = ? ))', "%#{search}%", false, lecture.id])
  end

  def self.find_for_rename(search)
    find(:all, :conditions => ['annotation = ? AND deleted = ?', search, false])
  end

  def self.find_for_rename_by_slideset(search, slideset)
   find(:all, :include => [:slide], :conditions => ['annotations.annotation = ? AND annotations.deleted = ? AND annotations.slide_id = slides.id AND slides.slideset_id = ?', search, false, slideset.id])
  end

  def self.find_for_rename_by_lecture(search, lecture)
    find(:all, :include => [:slide], :conditions => ['annotations.annotation = ? AND annotations.deleted = ? AND annotations.slide_id = slides.id AND slides.slideset_id IN (SELECT slidesets.id FROM slidesets WHERE ( slidesets.lecture_id = ? ))', search, false, lecture.id])
  end
end

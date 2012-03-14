# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: slidesets
#
#  id          :integer         not null, primary key
#  title       :string(255)
#  lecture_id  :integer
#  deleted     :boolean
#  created_at  :datetime        not null
#  updated_at  :datetime        not null
#  description :text
#

class Slideset < ActiveRecord::Base
  belongs_to :lecture
  has_many :slides, dependent: :destroy, :order => "position"

  validates :lecture_id, presence: true
  validates :title, presence: true
end

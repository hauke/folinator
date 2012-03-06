# == Schema Information
#
# Table name: slidesets
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  lecture_id :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Slideset < ActiveRecord::Base
  belongs_to :lecture
  has_many :slides
end

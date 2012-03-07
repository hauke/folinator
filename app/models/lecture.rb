# == Schema Information
#
# Table name: lectures
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Lecture < ActiveRecord::Base
  has_many :slidesets, dependent: :destroy
end

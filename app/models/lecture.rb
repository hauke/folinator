# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: lectures
#
#  id         :integer         not null, primary key
#  title      :string(255)
#  deleted    :boolean
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

class Lecture < ActiveRecord::Base
  has_many :slidesets, dependent: :destroy
end

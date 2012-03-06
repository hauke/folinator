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

class Annotation < ActiveRecord::Base
  belongs_to :slide
end

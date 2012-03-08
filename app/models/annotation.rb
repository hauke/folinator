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

  validates :slide_id, presence: true
  validates :annotation, presence: true

  def self.search(search)
    if search
      find(:all, :conditions => ['annotation LIKE ?', "%#{search}%"])
    else
      find(:all)
    end
  end
end

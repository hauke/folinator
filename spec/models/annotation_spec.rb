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

require 'spec_helper'

describe Annotation do
  pending "add some examples to (or delete) #{__FILE__}"
end

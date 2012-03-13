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

require 'spec_helper'

describe Lecture do
  pending "add some examples to (or delete) #{__FILE__}"
end

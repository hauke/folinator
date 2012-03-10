# == Schema Information
#
# Table name: users
#
#  id           :integer         not null, primary key
#  identity_url :string(255)
#  email        :string(255)
#  name         :string(255)
#  admin        :boolean
#  created_at   :datetime        not null
#  updated_at   :datetime        not null
#

require 'spec_helper'

describe User do
  pending "add some examples to (or delete) #{__FILE__}"
end

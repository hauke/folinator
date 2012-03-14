# -*- encoding : utf-8 -*-
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
  before do
    @user = Factory :user
  end
  describe "test openid_fields" do  
    before do
      @user=User.build_from_identity_url("https://openid.tzi.de/Test")
      @user.openid_fields = {'http://openid.tzi.de/spec/schema/displayName' => 'Test', 'http://openid.tzi.de/spec/schema/mail' => "Test@test.com"}
    end
    it "identity_url is https://openid.tzi.de/Test" do  
      @user.identity_url.should eql("https://openid.tzi.de/Test")
    end
    it "name is Test" do
      @user.name.should eql("Test")
    end
    it "email is Test@test.com" do
      @user.email.should eql("Test@test.com")
    end
  end
end

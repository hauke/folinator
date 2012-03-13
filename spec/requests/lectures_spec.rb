require 'spec_helper'

describe "Lectures" do
  before do
    @user = Factory :admin
    @user.save
    visit new_user_session_path
    page.select("#{@user.name} (#{@user.email})", :from => 'user_id' ) 
    click_button "Sign in"
    @lecture = Factory :lecture
  end
  
  subject { page }

  describe "GET /lectures" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit lectures_path
      should have_content(@lecture.title)
    end
  end
end

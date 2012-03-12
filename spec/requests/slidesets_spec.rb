require 'spec_helper'


describe "Slidesets" do
  before do
    @user = Factory :admin
    @user.save
    visit new_user_session_path
    page.select("#{@user.name} (#{@user.email})", :from => 'user_id' ) 
    click_button "Sign in"
    @slideset = Factory :slideset
  end
  
  subject { page }
  
  describe "GET /slidesets" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit slidesets_path
      should have_content(@slideset.title)
    end
  end
  
  describe "POST /edit"
    it "can add description" do
    visit edit_slideset_path(@slideset)
    fill_in("slideset_description", :with => "Testtesttest")
    expect { click_button "Update Slideset" }.to change{current_path}.to(slidesets_path)  and have_content("Testtesttest")
  end
end

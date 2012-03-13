require 'spec_helper'


describe "Slidesets" do
  before do
    @user = Factory :admin
    @user.save
    visit new_user_session_path
    page.select("#{@user.name} (#{@user.email})", :from => 'user_id' ) 
    click_button "Sign in"
    @lecture = Factory :lecture
    @slideset = Factory :slideset, lecture: @lecture
  end
  
  subject { page }
  
  describe "POST /edit"
    it "can add description" do
    visit edit_slideset_path(@slideset)
    fill_in("slideset_description", :with => "Testtesttest")
    expect { click_button "Update Slideset" }.to change{current_path}.to(slideset_slides_path(@slideset))  and have_content("Testtesttest")
  end
end

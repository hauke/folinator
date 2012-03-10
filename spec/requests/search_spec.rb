require 'spec_helper'

describe "Search" do
  before do 
    @user = Factory :admin
    @user.save
    visit new_user_session_path
    page.select("#{@user.name} (#{@user.email})", :from => 'user_id' ) 
    click_button "Sign in"
    @slideset = Factory :slideset
    @slides = 3.times.map{ FactoryGirl.create(:slide, :slideset => @slideset) }
    @slides.each do |slide|
      Factory :annotation, :slide => slide
      
    end
    
  end
  
  describe "Find something" do
    before do
      @slide4 = Factory :slide, :slideset => @slideset
      @slide4.annotations.create(annotation: "Test")
    end
    it "should find slide4" do
      visit slidesets_path
      fill_in "search", with: "Test" 
      expect { click_button "Search"}.to change{current_path}.to(searchresults_path)
    end
  end
  describe "Find nothing" do
    it "should find nothing" do
      visit slidesets_path
      fill_in "search", with: "Test" 
      click_button "Search"
      page.should have_content('Nothing found')
    end
  end
end

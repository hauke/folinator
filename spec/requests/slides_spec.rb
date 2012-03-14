# -*- encoding : utf-8 -*-
require 'spec_helper'


describe "Slides" do
  before do 
    @user = Factory :admin
    @user.save
    visit new_user_session_path
    page.select("#{@user.name} (#{@user.email})", :from => 'user_id' ) 
    click_button "Sign in"
    @slideset= Factory :slideset
    @slide, @slide2, @slide3 = 3.times.map{ Factory :slide, :slideset => @slideset }
  end
  
  subject { page }

  describe "GET /slides" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit slideset_slides_path(@slideset)
      should have_content("Listing slides (#{@slideset.title})")
    end
  end
  describe "GET next slide" do
    it "should take me to next slide" do
      visit slideset_slide_path(@slideset, @slide)
      expect { click_link "Next"}.to change{current_path}.to(slideset_slide_path(@slideset, @slide2))
    end
    it "should not go past the last slide" do
      visit slideset_slide_path(@slideset, @slide3)
      should_not have_link("Next")
    end
  end
  describe "GET previous slide" do 
    it "should take me to previous slide" do
      visit slideset_slide_path(@slideset, @slide2)
      expect { click_link "Previous"}.to change{current_path}.to(slideset_slide_path(@slideset, @slide))
    end
    it "should not go before the first slide" do
      visit slideset_slide_path(@slideset, @slide)
      should_not have_link("Previous")
    end
  end
  describe "GET last slide" do
    it "should take me to last slide" do
      visit slideset_slide_path(@slideset, @slide)
      expect { click_link "Last"}.to change{current_path}.to(slideset_slide_path(@slideset, @slide3))
    end
    it "should not go before the first slide" do
      visit slideset_slide_path(@slideset, @slide3)
      should_not have_link("Last")
      should have_link("First")
    end
  end
  describe "GET first slide" do
    it "should take me to last slide" do
      visit slideset_slide_path(@slideset, @slide3)
      expect { click_link "First"}.to change{current_path}.to(slideset_slide_path(@slideset, @slide))
    end
    it "should not go before the first slide" do
      visit slideset_slide_path(@slideset, @slide)
      should_not have_link("First")
      should have_link("Last")
    end
  end
  describe "set Title-Annotation" do
    before do
      @annotation, @annotation2 = 2.times.map { Factory :annotation, :slide => @slide }
    end
    it "should show the title annotation in slide/index" do
      visit slideset_slide_path(@slideset, @slide)
      choose("annotation_id_#{@annotation.id}")
      click_button("Select as title")
      click_link("Back")
      should have_content(@annotation.annotation)
    end
  end
end

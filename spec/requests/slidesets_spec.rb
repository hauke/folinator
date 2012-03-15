# -*- encoding : utf-8 -*-
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

  describe "GET /slidesets/new" do
    it "should return new_slideset" do
      visit lecture_path(@lecture)
      expect { click_link "Neuen Foliensatz hinzufügen"}.to change{current_path}.to(new_lecture_slideset_path(@lecture))
    end
  end
  describe "GET /slidesets/edit"
   it "should return edit_slideset" do
     visit lecture_path(@lecture)
     expect { click_link "Bearbeiten"}.to change{current_path}.to(edit_slideset_path(@lecture))
  end
  describe "POST mark_deleted_slidesets" do
    it "should mark slideset as deleted" do
      visit lecture_path(@lecture)
      click_link "Ausblenden"
      should have_content("Einblenden")
    end   
  end
  describe "POST unmark_deleted_lecture" do
    it "should bring back slideset" do
      visit lecture_path(@lecture)
      click_link "Ausblenden"
      click_link "Einblenden"
      should have_content("Ausblenden")
    end   
  end
  describe "POST delete_slideset" do
    it "should delete the slideset" do
      visit lecture_path(@lecture)
      expect { click_link "Löschen" }.to change(Slideset, :count).by(-1)
    end
  end
end

# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "Lectures" do
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

  describe "GET /lectures" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit lectures_path
      should have_content(@lecture.title)
    end
  end

  describe "GET /slidesets" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      visit lecture_path(@lecture)
      should have_content(@slideset.title)
    end
  end
  describe "GET /lectures/new" do
    it "should return new_lecture" do
      visit root_path
      expect { click_link "Neue Vorlesung hinzufügen"}.to change{current_path}.to(new_lecture_path)
    end
  end
  describe "GET /lectures/edit"
   it "should return edit_lecture" do
     visit root_path
     expect { click_link "Bearbeiten"}.to change{current_path}.to(edit_lecture_path(@lecture))
  end
  describe "POST mark_deleted_lecture" do
    it "should mark lecture as deleted" do
      visit root_path
      click_link "Ausblenden"
      should have_content("Einblenden")
    end   
  end
  describe "POST unmark_deleted_lecture" do
    it "should bring back lecture" do
      visit root_path
      click_link "Ausblenden"
      click_link "Einblenden"
      should have_content("Ausblenden")
    end   
  end
  describe "POST delete_lecture" do
    it "should delete the lecture" do
      visit root_path
      expect { click_link "Löschen" }.to change(Lecture, :count).by(-1)
    end
  end
end

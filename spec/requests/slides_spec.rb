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
      should have_content("Foliensatz #{@slideset.title}")
    end
  end
  describe "GET Vor slide" do
    it "should take me to Vor slide" do
      visit slideset_slide_path(@slideset, @slide)
      expect { click_link "Vor"}.to change{current_path}.to(slideset_slide_path(@slideset, @slide2))
    end
    it "should not go past the Ende slide" do
      visit slideset_slide_path(@slideset, @slide3)
      should_not have_link("Vor")
    end
  end
  describe "GET Zurück slide" do 
    it "should take me to Zurück slide" do
      visit slideset_slide_path(@slideset, @slide2)
      expect { click_link "Zurück"}.to change{current_path}.to(slideset_slide_path(@slideset, @slide))
    end
    it "should not go before the Anfang slide" do
      visit slideset_slide_path(@slideset, @slide)
      should_not have_link("Zurück")
    end
  end
  describe "GET Ende slide" do
    it "should take me to Ende slide" do
      visit slideset_slide_path(@slideset, @slide)
      expect { click_link "Ende"}.to change{current_path}.to(slideset_slide_path(@slideset, @slide3))
    end
    it "should not go before the Anfang slide" do
      visit slideset_slide_path(@slideset, @slide3)
      should_not have_link("Ende")
      should have_link("Anfang")
    end
  end
  describe "GET Anfang slide" do
    it "should take me to Ende slide" do
      visit slideset_slide_path(@slideset, @slide3)
      expect { click_link "Anfang"}.to change{current_path}.to(slideset_slide_path(@slideset, @slide))
    end
    it "should not go before the Anfang slide" do
      visit slideset_slide_path(@slideset, @slide)
      should_not have_link("Anfang")
      should have_link("Ende")
    end
  end
  describe "set Title-Annotation" do
    before do
      @annotation, @annotation2 = 2.times.map { Factory :annotation, :slide => @slide }
    end
    it "should show the title annotation in slide/index" do
      visit slideset_slide_path(@slideset, @slide)
      choose("annotation_id_#{@annotation.id}")
      click_button("Speichern")
      should have_content(@annotation.annotation)
    end
  end  
  describe "Last Author" do
    before do  
      @annotation = Factory :annotation, :slide => @slide
    end
    it "should remember last Author" do
      visit slideset_slide_path(@slideset, @slide)
      expect { click_link "Ausblenden" 
      @annotation.reload}.to change(@annotation, :last_author_id).to(@user.id)   
    end 
  end   
  describe "mark slide as deleted" do
    it "should mark slide as deleted" do
      visit slideset_slides_path(@slideset)
      within("#slide_1") { click_button "Ausblenden" }
      within("#slide_1") { should have_button("Einblenden") }
    end 
    it "should leave the slide numbers sorted" do
      visit slideset_slides_path(@slideset)
      within("#slide_2") { click_button "Ausblenden" }
      within("#slide_3") { should have_content("2") }
    end  
  end
  describe "unmark slide as deleted" do
    it "should mark slide as deleted" do
      visit slideset_slides_path(@slideset)
      within("#slide_1") { click_button "Ausblenden" }
      within("#slide_1") { click_button "Einblenden" }
      within("#slide_1") { should have_button("Ausblenden") }
    end 
    it "should leave the slide numbers sorted" do
      visit slideset_slides_path(@slideset)
      within("#slide_2") { click_button "Ausblenden" }
      within("#slide_2") { click_button "Einblenden" }     
      within("#slide_3") { should have_content("3") } && within("#slide_2") { should have_content("2") }
    end  
  end
  describe "pdf generation" do
    it "generate valid pdf" do
      visit slideset_slides_path(@slideset)
      click_link "Als PDF herunterladen"
      should have_content("%PDF-1.3")
    end
  end
end

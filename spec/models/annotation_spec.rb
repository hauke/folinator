# -*- encoding : utf-8 -*-
# == Schema Information
#
# Table name: annotations
#
#  id             :integer         not null, primary key
#  annotation     :string(255)
#  slide_id       :integer
#  deleted        :boolean
#  last_author_id :integer
#  created_at     :datetime        not null
#  updated_at     :datetime        not null
#

require 'spec_helper'

describe Annotation do
  before do
    @user = Factory :user
    @lecture, @lecture2 = 2.times.map{Factory :lecture}
    @slidesets = 2.times.map{Factory :slideset, lecture: @lecture}
    @slidesets2 = 2.times.map{Factory :slideset, lecture: @lecture2}
    @slidesets.each do |slideset|
      @slides = 3.times.map{ FactoryGirl.create(:slide, :slideset => slideset) }
      @slides.each do |slide|
        Factory :annotation, :slide => slide
      end
    end
    @slidesets2.each do |slideset|
      @slides2 = 3.times.map{ FactoryGirl.create(:slide, :slideset => slideset) }
      @slides2.each do |slide|
        Factory :annotation, :slide => slide
      end
    end
    @annotation1 = Annotation.new(annotation: "Test", last_author: @user)
    @annotation = @slidesets[0].slides[0].annotations.create!(annotation: "Karl", last_author: @user)
    @annotation2 = @slidesets2[0].slides[0].annotations.create!(annotation: "Karl Heinz Meier", last_author: @user)
    @annotation3 = @slidesets2[1].slides[0].annotations.create!(annotation: "Karl Heinz Müller", last_author: @user)
    @annotation4 = @slidesets2[1].slides[2].annotations.create!(annotation: "Karl", last_author: @user)
    @annotation5 = @slidesets2[1].slides[1].annotations.create!(annotation: "Karl Heinz Meier", last_author: @user)
  end
  subject { @annotation1 }
  
  describe "slide:" do
    describe "do not belong to a slide" do
      before {}
      it { should_not be_valid }
    end
    describe "belongs to a slide" do
      before { @annotation1.slide = @slides[2] }
      it { should be_valid }
    end
  end
  describe "find to rename" do
    it"should find Karl Heinz Meier" do
      anno = Annotation.find_for_rename("Karl Heinz Meier")
      anno.should eq([@annotation2, @annotation5]) 
    end 
    it "should find only Karl" do
      anno = Annotation.find_for_rename("Karl")
      anno.should eq([@annotation, @annotation4])
    end
  end
  describe "find to rename in scope lecture" do
    it "should find only one Karl" do
      anno = Annotation.find_for_rename_by_lecture("Karl", @lecture)
      anno.should eq([@annotation])
    end
  end
  describe "find to rename in scope slideset" do
    it "should find only one Karl Heinz Meier" do
      anno = Annotation.find_for_rename_by_slideset("Karl Heinz Meier", @slidesets2[1])
      anno.should eq([@annotation5])
    end
  end
  describe "search" do
    it"should find Karl Heinz Meier" do
      anno = Annotation.search("Karl Heinz Meier")
      anno.should eq([@annotation2, @annotation5]) 
    end 
    it "should find only all Karls" do
      anno = Annotation.search("Karl")
      anno.should eq([@annotation, @annotation2, @annotation3, @annotation4, @annotation5])
    end
  end
  describe "search in scope lecture" do
    it "should find only one Karl" do
      anno = Annotation.search_by_lecture("Karl", @lecture)
      anno.should eq([@annotation])
    end
  end
  describe "search in scope slideset" do
    it "should find only one Karl Heinz Meier" do
      anno = Annotation.search_by_slideset("Karl Heinz Meier", @slidesets2[1])
      anno.should eq([@annotation5])
    end
  end
end

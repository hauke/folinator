# == Schema Information
#
# Table name: annotations
#
#  id         :integer         not null, primary key
#  annotation :string(255)
#  slide_id   :integer
#  created_at :datetime        not null
#  updated_at :datetime        not null
#

require 'spec_helper'

describe Annotation do
  before do 
    @slideset = Slideset.new(title:"Test")
    @slideset.save
    @slide = Slide.new(image:"Testslide")
    @slide.slideset = @slideset
    @slide.save
    @annotation = Annotation.new(annotation:"this is a test")
  end
  subject { @annotation }
  
  describe "slide:" do
    describe "do not belong to a slide" do
      it { should_not be_valid }
    end
    describe "belongs to a slide" do
      before { @annotation.slide = @slide }
      it { should be_valid }
    end
  end
end

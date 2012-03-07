require 'spec_helper'

describe Slide do
  before do
    @slideset = Slideset.new(title:"test")
    @slideset.save
    @slide = Slide.new(filepath:"Testslide")
  end
  subject { @slide }
  
  describe "slideset:" do
    describe "do not belong to a slideset" do
      it { should_not be_valid }
    end
    describe "belongs to a slideset" do
      before { @slideset.slides << @slide } 
      it { should be_valid }
    end
  end


end

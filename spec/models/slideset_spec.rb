require 'spec_helper'

describe Slideset do
  before do	
    @slideset= Slideset.new(title:"Testset")
  end
  subject { @slideset }
  
  describe "can create slides" do
   before { @slideset.save }   
   it "should create sliedes" do
     expect { @slideset.slides.create }.to change(Slide, :count).by(1)
   end
  end
end

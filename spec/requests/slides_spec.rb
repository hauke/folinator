require 'spec_helper'

describe "Slides" do
  before do 
    @slideset=Slideset.create(title:"Testset")
  end
  describe "GET /slides" do
    it "works! (now write some real specs)" do
      # Run the generator again with the --webrat flag if you want to use webrat methods/matchers
      get slideset_slides_path(@slideset)
      response.status.should be(200)
    end
  end
end

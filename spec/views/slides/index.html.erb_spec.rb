require 'spec_helper'

describe "slides/index" do
  before(:each) do
    @lecture = Factory :lecture
    @slideset = Factory :slideset, lecture: @lecture
    
    assign(:slides, [
      stub_model(Slide, :slideset_id => @slideset.id),
      stub_model(Slide, :slideset_id => @slideset.id)
    ])
  end

  it "renders a list of slides" do
    render
  end
end

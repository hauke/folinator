require 'spec_helper'

describe "slides/show" do
  before(:each) do
    @slideset=Slideset.create(title:"test")
    @slide = assign(:slide, stub_model(Slide, :slideset_id => @slideset.id))
  end

  it "renders attributes in <p>" do
    render
  end
end

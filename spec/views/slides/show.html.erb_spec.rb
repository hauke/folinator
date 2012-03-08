require 'spec_helper'

describe "slides/show" do
  before(:each) do
    @slideset=Slideset.create(title:"test")
    @slide = assign(:slide, stub_model(Slide, :slideset => @slideset))
    @slideset.slides << @slide
    @annotations = []
    @annotation_new = Annotation.new
  end

  it "renders attributes in <p>" do
    render
  end
end

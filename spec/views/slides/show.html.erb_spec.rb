require 'spec_helper'

describe "slides/show" do
  before(:each) do
    @lecture = Factory :lecture
    @slideset =  Factory :slideset, lecture: @lecture
    @slide = assign(:slide, stub_model(Slide, :slideset => @slideset))
    @slideset.slides << @slide
    @annotations = []
    @annotation_new = Annotation.new
    @surrounding_annotations = []
  end

  it "renders attributes in <p>" do
    render
  end
end

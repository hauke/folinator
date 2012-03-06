require 'spec_helper'

describe "annotations/show" do
  before(:each) do
    @annotation = assign(:annotation, stub_model(Annotation))
  end

  it "renders attributes in <p>" do
    render
  end
end

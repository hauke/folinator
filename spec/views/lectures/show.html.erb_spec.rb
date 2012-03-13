require 'spec_helper'

describe "lectures/show" do
  before(:each) do
    @lecture = assign(:lecture, stub_model(Lecture))
    
    assign(:slidesets, [
      stub_model(Slideset, :lecture_id => @lecture.id),
      stub_model(Slideset, :lecture_id => @lecture.id)
    ])
  end

  it "renders attributes in <p>" do
    render
  end
end

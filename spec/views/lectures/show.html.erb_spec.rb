require 'spec_helper'

describe "lectures/show" do
  before(:each) do
    @lecture = assign(:lecture, stub_model(Lecture))
  end

  it "renders attributes in <p>" do
    render
  end
end

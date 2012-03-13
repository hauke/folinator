require 'spec_helper'

describe "lectures/index" do
  before(:each) do
    assign(:lectures, [
      stub_model(Lecture),
      stub_model(Lecture)
    ])
  end

  it "renders a list of lectures" do
    render
  end
end

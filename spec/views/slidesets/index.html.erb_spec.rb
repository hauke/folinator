require 'spec_helper'

describe "slidesets/index" do
  before(:each) do
    assign(:slidesets, [
      stub_model(Slideset),
      stub_model(Slideset)
    ])
  end

  it "renders a list of slidesets" do
    render
  end
end

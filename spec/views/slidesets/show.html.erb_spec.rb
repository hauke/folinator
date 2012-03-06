require 'spec_helper'

describe "slidesets/show" do
  before(:each) do
    @slideset = assign(:slideset, stub_model(Slideset))
  end

  it "renders attributes in <p>" do
    render
  end
end

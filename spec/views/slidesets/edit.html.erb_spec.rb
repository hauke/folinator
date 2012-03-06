require 'spec_helper'

describe "slidesets/edit" do
  before(:each) do
    @slideset = assign(:slideset, stub_model(Slideset))
  end

  it "renders the edit slideset form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => slidesets_path(@slideset), :method => "post" do
    end
  end
end

require 'spec_helper'

describe "slidesets/new" do
  before(:each) do
    assign(:slideset, stub_model(Slideset).as_new_record)
  end

  it "renders new slideset form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => slidesets_path, :method => "post" do
    end
  end
end

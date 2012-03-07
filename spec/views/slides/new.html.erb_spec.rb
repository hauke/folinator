require 'spec_helper'

describe "slides/new" do
  before(:each) do 
    @slideset=Slideset.create(title:"test")
    assign(:slide, stub_model(Slide, :slideset_id => @slideset.id).as_new_record)
  end

  it "renders new slide form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => slideset_slides_path(@slideset), :method => "post" do
    end
  end
end

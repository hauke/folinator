# -*- encoding : utf-8 -*-
require 'spec_helper'

describe "slides/edit" do
  before(:each) do
    @lecture = Factory :lecture
    @slideset = Factory :slideset, lecture: @lecture
    @slide = assign(:slide, stub_model(Slide, :slideset_id => @slideset.id))
  end

  it "renders the edit slide form" do
    render

    # Run the generator again with the --webrat flag if you want to use webrat matchers
    assert_select "form", :action => slideset_slides_path(@slideset, @slide), :method => "post" do
    end
  end
end

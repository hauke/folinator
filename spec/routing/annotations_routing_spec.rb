# -*- encoding : utf-8 -*-
require "spec_helper"

describe AnnotationsController do
  describe "routing" do

    it "routes to #index" do
      get("annotations").should route_to("annotations#index")
    end

    it "routes to #create" do
      post("slidesets/1/slides/1/annotations").should route_to("annotations#create", "expect"=>[:new, :edit], "slide_id" => "1", "slideset_id" => "1")
    end

    it "routes to #destroy" do
      delete("slidesets/1/slides/1/annotations/1").should route_to("annotations#destroy", "expect"=>[:new, :edit], :id => "1", "slide_id" => "1", "slideset_id" => "1")
    end

  end
end

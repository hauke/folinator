require "spec_helper"

describe AnnotationsController do
  describe "routing" do

    it "routes to #index" do
      get("slidesets/1/slides/1/annotations").should route_to("annotations#index", "slide_id" => "1", "slideset_id" => "1")
    end

    it "routes to #new" do
      get("slidesets/1/slides/1/annotations/new").should route_to("annotations#new", "slide_id" => "1", "slideset_id" => "1")
    end

    it "routes to #show" do
      get("slidesets/1/slides/1/annotations/1").should route_to("annotations#show", :id => "1", "slide_id" => "1", "slideset_id" => "1")
    end

    it "routes to #edit" do
      get("slidesets/1/slides/1/annotations/1/edit").should route_to("annotations#edit", :id => "1", "slide_id" => "1", "slideset_id" => "1")
    end

    it "routes to #create" do
      post("slidesets/1/slides/1/annotations").should route_to("annotations#create", "slide_id" => "1", "slideset_id" => "1")
    end

    it "routes to #update" do
      put("slidesets/1/slides/1/annotations/1").should route_to("annotations#update", :id => "1", "slide_id" => "1", "slideset_id" => "1")
    end

    it "routes to #destroy" do
      delete("slidesets/1/slides/1/annotations/1").should route_to("annotations#destroy", :id => "1", "slide_id" => "1", "slideset_id" => "1")
    end

  end
end

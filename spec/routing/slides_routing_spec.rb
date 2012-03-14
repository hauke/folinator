# -*- encoding : utf-8 -*-
require "spec_helper"

describe SlidesController do
  describe "routing" do
#{"action"=>"index", "controller"=>"slides", "slideset_id"=>"1"}> did not match <{"controller"=>"slidesets/1/slides", "action"=>"index"}>, difference: <{"controller"=>"slidesets/1/slides", "slideset_id"=>"1"}
    it "routes to #index" do
      get("slidesets/1/slides").should route_to("slides#index", "slideset_id"=>"1")
    end

    it "routes to #new" do
      get("slidesets/1/slides/new").should route_to("slides#new", "slideset_id"=>"1")
    end

    it "routes to #show" do
      get("slidesets/1/slides/1").should route_to("slides#show", :id => "1", "slideset_id"=>"1")
    end

    it "routes to #edit" do
      get("slidesets/1/slides/1/edit").should route_to("slides#edit", :id => "1", "slideset_id"=>"1")
    end

    it "routes to #create" do
      post("slidesets/1/slides").should route_to("slides#create", "slideset_id"=>"1")
    end

    it "routes to #update" do
      put("slidesets/1/slides/1").should route_to("slides#update", :id => "1", "slideset_id"=>"1")
    end

    it "routes to #destroy" do
      delete("slidesets/1/slides/1").should route_to("slides#destroy", :id => "1", "slideset_id"=>"1")
    end

  end
end

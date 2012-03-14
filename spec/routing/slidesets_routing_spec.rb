# -*- encoding : utf-8 -*-
require "spec_helper"

describe SlidesetsController do
  describe "routing" do

    it "routes to #index" do
      get("/slidesets").should route_to("slidesets#index")
    end

    it "routes to #new" do
      get("/slidesets/new").should route_to("slidesets#new")
    end

    it "routes to #show" do
      get("/slidesets/1").should route_to("slidesets#show", :id => "1")
    end

    it "routes to #edit" do
      get("/slidesets/1/edit").should route_to("slidesets#edit", :id => "1")
    end

    it "routes to #create" do
      post("/slidesets").should route_to("slidesets#create")
    end

    it "routes to #update" do
      put("/slidesets/1").should route_to("slidesets#update", :id => "1")
    end

    it "routes to #destroy" do
      delete("/slidesets/1").should route_to("slidesets#destroy", :id => "1")
    end

  end
end

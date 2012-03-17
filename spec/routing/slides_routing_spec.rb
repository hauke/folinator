# -*- encoding : utf-8 -*-
require "spec_helper"

describe SlidesController do
  describe "routing" do
    it "routes to #index" do
      get("slidesets/1/slides").should route_to("slides#index", expect: [:new, :edit], "slideset_id"=>"1")
    end

    it "routes to #new" do
      get("slidesets/1/slides/new").should route_to("slides#new", expect: [:new, :edit], "slideset_id"=>"1")
    end

    it "routes to #show" do
      get("slidesets/1/slides/1").should route_to("slides#show", expect: [:new, :edit], :id => "1", "slideset_id"=>"1")
    end

    it "routes to #edit" do
      get("slidesets/1/slides/1/edit").should route_to("slides#edit", expect: [:new, :edit], :id => "1", "slideset_id"=>"1")
    end

    it "routes to #create" do
      post("slidesets/1/slides").should route_to("slides#create", expect: [:new, :edit], "slideset_id"=>"1")
    end

    it "routes to #update" do
      put("slidesets/1/slides/1").should route_to("slides#update", expect: [:new, :edit], :id => "1", "slideset_id"=>"1")
    end

    it "routes to #destroy" do
      delete("slidesets/1/slides/1").should route_to("slides#destroy", expect: [:new, :edit], :id => "1", "slideset_id"=>"1")
    end

  end
end

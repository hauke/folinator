require 'spec_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

describe SlidesController do
  login_admin
  
  before do
    @slideset = Slideset.create( title: "test") 
    @file = fixture_file_upload( "/folie-0001-256-w50k.png", "image/png")
  end
  # This should return the minimal set of attributes required to create a valid
  # Slide. As you add validations to Slide, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {image: get_image_stream, slideset_id:@slideset.id}
  end
  

  def valid_http_attributes
    {image: @file, slideset_id:@slideset.id}
  end
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # SlidesController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all slides as @slides" do
      slide = Slide.create! valid_attributes
      get :index, {slideset_id:@slideset.id}, valid_session
      assigns(:slides).should eq([slide])
    end
  end

  describe "GET show" do
    it "assigns the requested slide as @slide" do
      slide = Slide.create! valid_attributes
      get :show, {:id => slide.to_param, slideset_id:@slideset.id}, valid_session
      assigns(:slide).should eq(slide)
    end
  end

  describe "GET new" do
    it "assigns a new slide as @slide" do
      get :new, {slideset_id:@slideset.id}, valid_session
      assigns(:slide).should be_a_new(Slide)
    end
  end

  describe "GET edit" do
    it "assigns the requested slide as @slide" do
      slide = Slide.create! valid_attributes
      get :edit, {:id => slide.to_param, slideset_id:@slideset.id}, valid_session
      assigns(:slide).should eq(slide)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Slide" do
        expect {
          post :create, {:slide => valid_http_attributes, slideset_id:@slideset.id}, valid_session
        }.to change(Slide, :count).by(1)
      end

      it "assigns a newly created slide as @slide" do
        post :create, {:slide => valid_http_attributes,slideset_id:@slideset.id}, valid_session
        assigns(:slide).should be_a(Slide)
        assigns(:slide).should be_persisted
      end

      it "redirects to the created slide" do
        post :create, {:slide => valid_http_attributes, slideset_id:@slideset.id}, valid_session
        response.should redirect_to([@slideset,Slide.last])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved slide as @slide" do
        # Trigger the behavior that occurs when invalid params are submitted
        Slide.any_instance.stub(:save).and_return(false)
        post :create, {:slide => {}, slideset_id:@slideset.id}, valid_session
        assigns(:slide).should be_a_new(Slide)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Slide.any_instance.stub(:save).and_return(false)
        post :create, {:slide => {},slideset_id:@slideset.id}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested slide" do
        slide = Slide.create! valid_attributes
        # Assuming there are no other slides in the database, this
        # specifies that the Slide created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Slide.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => slide.to_param, :slide => {'these' => 'params'}, slideset_id:@slideset.id}, valid_session
      end

      it "assigns the requested slide as @slide" do
        slide = Slide.create! valid_attributes
        put :update, {:id => slide.to_param, :slide => valid_attributes,slideset_id:@slideset.id}, valid_session
        assigns(:slide).should eq(slide)
      end

      it "redirects to the slide" do
        slide = Slide.create! valid_attributes
        put :update, {:id => slide.to_param, :slide => valid_attributes,slideset_id:@slideset.id}, valid_session
        response.should redirect_to([@slideset,slide])
      end
    end

    describe "with invalid params" do
      it "assigns the slide as @slide" do
        slide = Slide.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Slide.any_instance.stub(:save).and_return(false)
        put :update, {:id => slide.to_param, :slide => {},slideset_id:@slideset.id}, valid_session
        assigns(:slide).should eq(slide)
      end

      it "re-renders the 'edit' template" do
        slide = Slide.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Slide.any_instance.stub(:save).and_return(false)
        put :update, {:id => slide.to_param, :slide => {},slideset_id:@slideset.id}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested slide" do
      slide = Slide.create! valid_attributes
      expect {
        delete :destroy, {:id => slide.to_param,slideset_id:@slideset.id}, valid_session
      }.to change(Slide, :count).by(-1)
    end

    it "redirects to the slides list" do
      slide = Slide.create! valid_attributes
      delete :destroy, {:id => slide.to_param,slideset_id:@slideset.id}, valid_session
      response.should redirect_to(slideset_slides_url(@slideset))
    end
  end
  describe "Edit_multiple" do
      it "write multiple annotations" do
      slide = Slide.create! valid_attributes
      slide2 = Slide.create! valid_attributes
      post :edit_multiple, {:slide_ids => [slide.id, slide2.id],annotation: "Test",slideset_id:@slideset.id}, valid_session
      response.should redirect_to slideset_slides_path(@slideset) 
    end
  end
  describe "POST set_title" do
    it "selects annotation as title" do
      slide = Slide.create! valid_attributes
      annotation = slide.annotations.create!(annotation: "test")
      post :set_title, {id: slide.id, annotation_id: annotation.id, slideset_id:@slideset.id}, valid_session
      response.should render_template("show")
    end
  end
end

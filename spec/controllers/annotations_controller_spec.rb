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

describe AnnotationsController do
  
  before do
    @slideset = Slideset.create( title: "test") 
    @slide = @slideset.slides.create(image: get_image_stream)
    
  end
  # This should return the minimal set of attributes required to create a valid
  # Annotation. As you add validations to Annotation, be sure to
  # update the return value of this method accordingly.
  def valid_attributes
    {slide_id:@slide.id, annotation:"Test"}
  end
  
  def valid_http_attributes
    {slide_id:@slide.id, annotation:"Test", slideset_id:@slideset.id}
  end
  
  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # AnnotationsController. Be sure to keep this updated too.
  def valid_session
    {}
  end

  describe "GET index" do
    it "assigns all annotations as @annotations" do
      annotation = Annotation.create! valid_attributes
      get :index, {}, valid_session
      assigns(:annotations).should eq([annotation])
    end
  end

  describe "GET show" do
    it "assigns the requested annotation as @annotation" do
      annotation = Annotation.create! valid_attributes
      get :show, {:id => annotation.to_param}, valid_session
      assigns(:annotation).should eq(annotation)
    end
  end

  describe "GET new" do
    it "assigns a new annotation as @annotation" do
      get :new, {}, valid_session
      assigns(:annotation).should be_a_new(Annotation)
    end
  end

  describe "GET edit" do
    it "assigns the requested annotation as @annotation" do
      annotation = Annotation.create! valid_attributes
      get :edit, {:id => annotation.to_param}, valid_session
      assigns(:annotation).should eq(annotation)
    end
  end

  describe "POST create" do
    describe "with valid params" do
      it "creates a new Annotation" do
        expect {
          post :create, {:annotation => valid_attributes, slide_id:@slide.id, slideset_id:@slideset.id}, valid_session
        }.to change(Annotation, :count).by(1)
      end

      it "assigns a newly created annotation as @annotation" do
        post :create, {:annotation => valid_attributes, slide_id:@slide.id, slideset_id:@slideset.id}, valid_session
        assigns(:annotation).should be_a(Annotation)
        assigns(:annotation).should be_persisted
      end

      it "redirects to the created annotation" do
        post :create, {:annotation => valid_attributes, slide_id:@slide.id, slideset_id:@slideset.id}, valid_session
        response.should redirect_to([@slideset,@slide])
      end
    end

    describe "with invalid params" do
      it "assigns a newly created but unsaved annotation as @annotation" do
        # Trigger the behavior that occurs when invalid params are submitted
        Annotation.any_instance.stub(:save).and_return(false)
        post :create, {:annotation => {}, slide_id:@slide.id, slideset_id:@slideset.id}, valid_session
        assigns(:annotation).should be_a_new(Annotation)
      end

      it "re-renders the 'new' template" do
        # Trigger the behavior that occurs when invalid params are submitted
        Annotation.any_instance.stub(:save).and_return(false)
        post :create, {:annotation => {}, slide_id:@slide.id, slideset_id:@slideset.id}, valid_session
        response.should render_template("new")
      end
    end
  end

  describe "PUT update" do
    describe "with valid params" do
      it "updates the requested annotation" do
        annotation = Annotation.create! valid_attributes
        # Assuming there are no other annotations in the database, this
        # specifies that the Annotation created on the previous line
        # receives the :update_attributes message with whatever params are
        # submitted in the request.
        Annotation.any_instance.should_receive(:update_attributes).with({'these' => 'params'})
        put :update, {:id => annotation.to_param, :annotation => {'these' => 'params'}}, valid_session
      end

      it "assigns the requested annotation as @annotation" do
        annotation = Annotation.create! valid_attributes
        put :update, {:id => annotation.to_param, :annotation => valid_attributes, slide_id:@slide.id, slideset_id:@slideset.id}, valid_session
        assigns(:annotation).should eq(annotation)
      end

      it "redirects to the annotation" do
        annotation = Annotation.create! valid_attributes
        put :update, {:id => annotation.to_param, :annotation => valid_attributes, slide_id:@slide.id, slideset_id:@slideset.id}, valid_session
        response.should redirect_to([@slideset,@slide])
      end
    end

    describe "with invalid params" do
      it "assigns the annotation as @annotation" do
        annotation = Annotation.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Annotation.any_instance.stub(:save).and_return(false)
        put :update, {:id => annotation.to_param, :annotation => {}}, valid_session
        assigns(:annotation).should eq(annotation)
      end

      it "re-renders the 'edit' template" do
        annotation = Annotation.create! valid_attributes
        # Trigger the behavior that occurs when invalid params are submitted
        Annotation.any_instance.stub(:save).and_return(false)
        put :update, {:id => annotation.to_param, :annotation => {}}, valid_session
        response.should render_template("edit")
      end
    end
  end

  describe "DELETE destroy" do
    it "destroys the requested annotation" do
      annotation = Annotation.create! valid_attributes
      expect {
        delete :destroy, {:id => annotation.to_param, slide_id:@slide.id, slideset_id:@slideset.id}, valid_session
      }.to change(Annotation, :count).by(-1)
    end

    it "redirects to the annotations list" do
      annotation = Annotation.create! valid_attributes
      delete :destroy, {:id => annotation.to_param, slide_id:@slide.id, slideset_id:@slideset.id}, valid_session
      response.should redirect_to([@slideset,@slide])
    end
  end

end

class SlidesController < ApplicationController
  # GET /slides
  # GET /slides.json
  def index
    @slideset = Slideset.find(params[:slideset_id])
    @slides = @slideset.slides
    authorize! :read, @slides

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slides }
    end
  end

  def search_by_annotation
    annotations = Annotation.search(params[:search])
    @slides = annotations.map{ |annotation| annotation.slide }
    @slides.uniq!
    authorize! :read, @slides

    respond_to do |format|
      format.html
      format.json { render json: @slides }
    end
  end

  # GET /slides/1
  # GET /slides/1.json
  def show
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:id])
    @annotations = @slide.annotations
    @annotation_new = Annotation.new
    authorize! :read, @slide
    @surrounding_annotations = surrounding_annotations
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @slide }
    end
  end

  # GET /slides/new
  # GET /slides/new.json
  def new
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.new
    authorize! :create, @slide

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slide }
    end
  end

  # GET /slides/1/edit
  def edit
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:id])
    authorize! :update, @slide
  end

  # POST /slides
  # POST /slides.json
  def create
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.new(params[:slide])
    authorize! :create, @slide

    respond_to do |format|
      if @slide.save
        format.html { redirect_to [@slideset, @slide], notice: 'Slide was successfully created.' }
        format.json { render json: @slide, status: :created, location: @slide }
      else
        format.html { render action: "new" }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /slides/1
  # PUT /slides/1.json
  def update
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:id])
    authorize! :update, @slide

    respond_to do |format|
      if @slide.update_attributes(params[:slide])
        format.html { redirect_to [@slideset, @slide], notice: 'Slide was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @slide.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slides/1
  # DELETE /slides/1.json
  def destroy
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:id])
    authorize! :destroy, @slide
    @slide.destroy

    respond_to do |format|
      format.html { redirect_to slideset_slides_url(@slideset) }
      format.json { head :no_content }
    end
  end

  def edit_multiple
    @slideset = Slideset.find(params[:slideset_id])
    unless (params[:slide_ids])
      authorize! :read, @slideset
      flash[:alert] = "No slides to annotate selected."
      redirect_to slideset_slides_path(@slideset)
      return
    end
    @slides = @slideset.slides.find(params[:slide_ids])
    @slides.each do |slide|
      annotation = slide.annotations.new(annotation: params[:annotation])
      authorize! :create, annotation
      annotation.save!
    end
    flash[:notice] = "Annotation #{params[:annotation]} added"
    redirect_to slideset_slides_path(@slideset)
  end

  def set_title
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:id])
    authorize! :set_title,  @slide
    @annotations = @slide.annotations
    @annotation_new = Annotation.new
    @annotation = @annotations.find(params[:annotation_id])
    @annotation.slide_title = @slide
    fill_for_show
    respond_to do |format|
      format.html { render :show }
      format.json { head :no_content }
    end
  end
  
  def copy_annotations 
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:id])
    @annotations = Annotation.find(params[:annotations_id])
    @annotations.each do |annotation|
      new_annotation = @slide.annotations.new(annotation: annotation.annotation)
      authorize! :create, annotation
      new_annotation.save
    end
    fill_for_show
    respond_to do |format|
      format.html { render :show }
      format.json { head :no_content }
    end
  end  
protected
  def fill_for_show
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:id])
    @annotations = @slide.annotations
    @annotation_new = Annotation.new
    authorize! :read, @slide
    @surrounding_annotations = surrounding_annotations
  end
  
  
  def surrounding_annotations
    surrounding_annotations = []
    
    surrounding_annotations += @slide.higher_item.annotations if @slide.higher_item     
    surrounding_annotations += @slide.lower_item.annotations if @slide.lower_item 
    
    surrounding_annotations.uniq
  end
end

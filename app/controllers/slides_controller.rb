class SlidesController < ApplicationController
  # GET /slides
  # GET /slides.json
  def index
    @slideset = Slideset.find(params[:slideset_id])
    @slides = @slideset.slides

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slides }
    end
  end

  def search_by_annotation
    annotations = Annotation.search(params[:search])
    @slides = annotations.map{ |annotation| annotation.slide }
    @slides.uniq!

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

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slide }
    end
  end

  # GET /slides/1/edit
  def edit
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:id])
  end

  # POST /slides
  # POST /slides.json
  def create
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.new(params[:slide])

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
    @slide.destroy

    respond_to do |format|
      format.html { redirect_to slideset_slides_url(@slideset) }
      format.json { head :no_content }
    end
  end

  def edit_multiple
    puts params
    @slideset = Slideset.find(params[:slideset_id])
    @slides = @slideset.slides.find(params[:slide_ids])
    @slides.each do |slide|
      slide.annotations.create(annotation: params[:annotation])
    end
    flash[:notice] = "Annotation #{params[:annotation]} added"
    redirect_to slideset_slides_path(@slideset)
  end
end

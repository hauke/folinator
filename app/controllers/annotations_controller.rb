class AnnotationsController < ApplicationController
  # GET /annotations
  # GET /annotations.json
  def index
    @annotations = Annotation.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @annotations }
    end
  end

  # GET /annotations/1
  # GET /annotations/1.json
  def show
    @annotation = Annotation.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @annotation }
    end
  end

  # GET /annotations/new
  # GET /annotations/new.json
  def new
    @annotation = Annotation.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @annotation }
    end
  end

  # GET /annotations/1/edit
  def edit
    @annotation = Annotation.find(params[:id])
  end

  # POST /annotations
  # POST /annotations.json
  def create
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:slide_id])
    @annotation = @slide.annotations.new(params[:annotation])

    respond_to do |format|
      if @annotation.save
        format.html { redirect_to slideset_slide_path(@slideset, @slide), notice: 'Annotation was successfully created.' }
        format.json { render json: @annotation, status: :created, location: @annotation }
      else
        format.html { render action: "new" }
        format.json { render json: @annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /annotations/1
  # PUT /annotations/1.json
  def update
    @annotation = Annotation.find(params[:id])

    respond_to do |format|
      if @annotation.update_attributes(params[:annotation])
        format.html { redirect_to [@annotation.slide.slideset,@annotation.slide], notice: 'Annotation was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /annotations/1
  # DELETE /annotations/1.json
  def destroy
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:slide_id])
    @annotation = @slide.annotations.find(params[:id])
    @annotation.destroy

    respond_to do |format|
      format.html { redirect_to slideset_slide_path(@slideset, @slide) }
      format.json { head :no_content }
    end
  end
end

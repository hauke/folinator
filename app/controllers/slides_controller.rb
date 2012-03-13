class SlidesController < ApplicationController
  # GET /slides
  # GET /slides.json
  def index
    @slideset = Slideset.find(params[:slideset_id])
    @slides = @slideset.slides
    authorize! :read, @slides
    @slide_new = Slide.new
    @lecture = @slideset.lecture

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slides }
    end
  end

  def search_by_annotation
    case params[:search_scope]
      when "all"
        annotations = Annotation.search(params[:search])
      when "lecture"
        @lecture = Lecture.find(params[:lecture_id])
        annotations = Annotation.search_by_lecture((params[:search]), @lecture)
      when "slideset"
        @slideset = Slideset.find(params[:slideset_id])
        @lecture = @slideset.lecture
        annotations = Annotation.search_by_slideset((params[:search]), @slideset)
    end

    @slides = annotations.map{ |annotation| annotation.slide }
    @slides.uniq!
    @search = params[:search]
    authorize! :read, @slides

    respond_to do |format|
      format.html
      format.json { render json: @slides }
    end
  end

  # GET /slides/1
  # GET /slides/1.json
  def show
    fill_for_show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @slide }
    end
  end

  # GET /slides/1
  # GET /slides/1.json
  def edit
    fill_for_show
    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @slide }
    end
  end
  
  # GET /slides/new
  # GET /slides/new.json
  def new
    @slideset = Slideset.find(params[:slideset_id])
    @lecture = @slideset.lecture
    @slide = @slideset.slides.new
    authorize! :create, @slide

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slide }
    end
  end

  # POST /slides
  # POST /slides.json
  def create
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.new(params[:slide])
    authorize! :create, @slide
    if params[:slide_after] && params[:slide_after] != "first"
      position = @slideset.slides.find(params[:slide_after]).position + 1
    else
      position = 0
      position = @slideset.slides[0].position if !@slideset.slides.empty? && @slideset.slides[0].position
    end
    @slide.insert_at(position)

    respond_to do |format|
      if @slide.save
        format.html { redirect_to [@slideset, @slide], notice: 'Slide was successfully created.' }
        format.json { render json: @slide, status: :created, location: @slide }
      else
        format.html { render action: "index" }
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
    @lecture = @slideset.lecture
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
    @lecture = @slideset.lecture
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
    rename_annotation
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

  def sort
    @slideset = Slideset.find(params[:slideset_id])
    @slides = @slideset.slides
    authorize! :update, @slides
    @slides.each do |slide|
      slide.position = params['slide'].index(slide.id.to_s) + 1
      slide.save
    end
    render :nothing => true
  end

protected
  def fill_for_show
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:id])
    @lecture = @slideset.lecture
    @annotations = @slide.annotations
    if !is_admin
      @annotations.select!{|annotation| !annotation.deleted}
    end
    @annotation_new = Annotation.new
    authorize! :read, @slide
    @surrounding_annotations = surrounding_annotations
  end
  
#   Parameters: {"utf8"=>"✓", "authenticity_token"=>"EAqW9QgppJ4nnCfZIg4/zftl3ObeQqphG+7NwY/k3tQ=", "annotation_id"=>"1", #"annotation_1"=>"", "rename_scope_1"=>"lecture", "annotation_2"=>"", "annotation_6"=>"UDP", "rename_scope_6"=>"lecture", #"annotation_7"=>"", "commit"=>"Select as title", "slideset_id"=>"1", "id"=>"1"}
  
  def rename_annotation
    puts params
    @annotations.each do |annotation|
            puts params["annotation_#{annotation.id}".to_sym]
      if not params["annotation_#{annotation.id}".to_sym].blank?
        puts params["annotation_#{annotation.id}".to_sym]
        case params["rename_scope_#{annotation.id}".to_sym]
          when "all"
            annotations = Annotation.search(annotation.annotation)
          when "lecture"
            lecture = @slide.slideset.lecture 
            annotations = Annotation.search_by_lecture(annotation.annotation, lecture)
          when "slideset"
            slideset = @slide.slideset
            annotations = Annotation.search_by_slideset(annotation.annotation, slideset)
        end
        return unless annotations
        annotations.each do |annos|
          annos.annotation = params["annotation_#{annotation.id}".to_sym]  
          annos.save        
        end
      end
    end 
  end
  
  def surrounding_annotations
    surrounding_annotations = {}
    surrounding_annotations.merge! Hash[*@slide.higher_item.annotations.map{|annotation| [annotation.annotation, annotation] }.flatten] if @slide.higher_item
    surrounding_annotations.merge! Hash[*@slide.lower_item.annotations.map{|annotation| [annotation.annotation, annotation] }.flatten] if @slide.lower_item
    surrounding_annotations.delete_if {|key, value| @slide.annotations.map{|annotation|  annotation.annotation}.include?(key) }
    surrounding_annotations.values
  end
end

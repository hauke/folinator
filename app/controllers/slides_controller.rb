# -*- encoding : utf-8 -*-
class SlidesController < ApplicationController
  # GET /slides
  # GET /slides.json
  def index
    authorize! :read, collection
    @slide_new = Slide.new
    @lecture = parent.lecture

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: collection }
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
        @lecture = parent.lecture
        annotations = Annotation.search_by_slideset((params[:search]), parent)
    end

    @slides = annotations.map{ |annotation| annotation.slide }
    @slides.uniq!
    @lectures = {}
    @slides.each do |slide|
      slideset = slide.slideset
      lecture = slideset.lecture
      if !is_admin
        next if slide.deleted || slideset.deleted || lecture.deleted
      end
      @lectures[lecture] = {} unless @lectures[lecture]
      @lectures[lecture][slideset] = [] unless @lectures[lecture][slideset]
      @lectures[lecture][slideset] << slide
    end
    @lectures.each do |lecture, slidesets|
      slidesets.each do |slideset, slides|
        slides.sort!{|x,y| x.position <=> y.position } 
      end
    end
    
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
      format.json { render json: resource }
    end
  end
  
  # GET /slides/new
  # GET /slides/new.json
  def new
    authorize! :create, build_resource
    @lecture = parent.lecture

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: resource }
    end
  end

  # POST /slides
  # POST /slides.json
  def create
    authorize! :create, build_resource
    build_resource.insert_at(params[:slide_after].to_i + 1)

    respond_to do |format|
      if resource.save
        parent.reoder_numbers
        format.html { redirect_to [parent, resource], notice: 'Slide was successfully created.' }
        format.json { render json: resource, status: :created, location: resource }
      else
        format.html { render action: "index" }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /slides/1
  # PUT /slides/1.json
  def update
    authorize! :update, resource

    respond_to do |format|
      if resource.update_attributes(params[:slide])
        parent.reoder_numbers
        format.html { redirect_to [parent, resource], notice: 'Slide was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "show" }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slides/1
  # DELETE /slides/1.json
  def destroy
    authorize! :destroy, resource
    resource.destroy
    parent.reoder_numbers

    respond_to do |format|
      format.html { redirect_to [parent, :slides] }
      format.json { head :no_content }
    end
  end

  def edit_multiple
    @lecture = parent.lecture
    unless (params[:slide_ids])
      authorize! :read, parent
      flash[:alert] = "No slides to annotate selected."
      redirect_to slideset_slides_path(parent)
      return
    end
    @slides = end_of_association_chain.find(params[:slide_ids])
    successful = []
    error = []
    @slides.each do |slide|
      annotation = slide.annotations.new(annotation: params[:annotation], last_author: current_user)
      authorize! :create, annotation
      if annotation.save
        successful << slide
      else
        error << slide
      end
    end
    flash[:notice] = "Schlagwort #{params[:annotation]} wurde zu Folien #{successful.map {|slide| slide.number}} hinzugefügt" unless successful.empty?
    flash[:alert] = "Schlagwort #{params[:annotation]} konnte nicht zu Folien #{error.map {|slide| slide.number}} hinzugefügt werden" unless error.empty?
    redirect_to slideset_slides_path(@slideset)
  end

  def set_title
    authorize! :set_title, resource
    @annotations = resource.annotations
    @annotation_new = Annotation.new
    @annotation = @annotations.find(params[:annotation_id])
    @annotation.slide_title = resource
    rename_annotation
    fill_for_show
    respond_to do |format|
      format.html { render :show }
      format.json { head :no_content }
    end
  end
    
  def copy_annotations
    @annotations = Annotation.find(params[:annotations_id])
    @annotations.each do |annotation|
      new_annotation = resource.annotations.new(annotation: annotation.annotation, last_author: current_user)
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
    authorize! :update, collection
    collection.each do |slide|
      slide.position = params['slide'].index(slide.id.to_s) + 1
      slide.save
    end
    parent.reload
    parent.reoder_numbers
    render :nothing => true
  end

  def mark_deleted
    authorize! :mark_deleted, resource
    resource.deleted = true

    respond_to do |format|
      if resource.save
        parent.reoder_numbers
        format.html { redirect_to slideset_slides_path(parent), notice: "Die Folie \"#{@slide.title ? @slide.title.annotation : @slide.number}\" wurde erfolgreich ausgeblendet" }
        format.json { render json: resource, status: :created, location: resource }
      else
        format.html { redirect_to slideset_slides_path(parent) }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def unmark_deleted
    authorize! :mark_deleted, resource
    resource.deleted = false

    respond_to do |format|
      if resource.save
        parent.reoder_numbers
        format.html { redirect_to slideset_slides_path(parent), notice: "Die Folie \"#{@slide.title ? @slide.title.annotation : @slide.number}\" wurde erfolgreich eingeblendet" }
        format.json { render json: resource, status: :created, location: resource }
      else
        format.html { redirect_to slideset_slides_path(parent) }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

protected

  def parent
    @slideset ||= Slideset.find(params[:slideset_id])
  end
  
  def resource
    @slide ||= end_of_association_chain.find(params[:id])
  end
  
  def build_resource
    @slide ||= end_of_association_chain.build(params[:slide])
  end
  
  def end_of_association_chain
    scope = parent.slides
    scope = scope.available unless is_admin
    scope
  end
  
  def collection
    @slides ||= end_of_association_chain.all
  end
  
  def fill_for_show
    @lecture     = parent.lecture
    @annotations = resource.annotations
    @annotations = @annotations.available unless is_admin
    
    @annotation_new = Annotation.new
    authorize! :read, @slide
    @surrounding_annotations = surrounding_annotations
  end
  
  def rename_annotation
    @annotations.each do |annotation|
      if not params["annotation_#{annotation.id}".to_sym].blank?
        case params["rename_scope_#{annotation.id}".to_sym]
          when "all"
            annotations = Annotation.find_for_rename(annotation.annotation)
          when "lecture"
            lecture = @slide.slideset.lecture 
            annotations = Annotation.find_for_rename_by_lecture(annotation.annotation, lecture)
          when "slideset"
            slideset = @slide.slideset
            annotations = Annotation.find_for_rename_by_slideset(annotation.annotation, slideset)
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

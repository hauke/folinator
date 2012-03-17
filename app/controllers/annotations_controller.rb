# -*- encoding : utf-8 -*-
class AnnotationsController < ApplicationController

  autocomplete :annotation, :annotation, :full => true, scopes: ["distincttag"]
  load_and_authorize_resource :only => [:autocomplete_annotation_annotation]

  # POST /annotations
  # POST /annotations.json
  def create
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:slide_id])
    if !params[:annotation] || params[:annotation].empty?
      authorize! :edit, @slide.annotations
      flash[:error]= 'Kein Schlgawort angegeben.'
    end
    error = []
    successful = []
    params[:annotation].each do |annotation|
      next if annotation.blank?
      @annotation = @slide.annotations.new(annotation: annotation, last_author: current_user)
      authorize! :create, @annotation
      if @annotation.save
        successful << @annotation.annotation
      else
        error << @annotation.annotation
      end
    end
    flash[:notice] = "Schlagworte #{successful} erfolgrch hinzugefügt." unless successful.empty?
    flash[:notce] = "Schlagworte #{error} konnten nicht hinzugefügt werden." unless error.empty?
    respond_to do |format|
      unless successful.empty?
        format.html { redirect_to slideset_slide_path(@slideset, @slide)}
        format.json { render json: @annotation, status: :created, location: @annotation }
      else
        format.html { redirect_to slideset_slide_path(@slideset, @slide)}
        format.json { render json: @annotation.errors, status: :unprocessable_entity }
      end
    end
  end
  
  def index
    @annotations = Annotation.all.sort_by{|x| x['updated_at']}
    authorize! :index, @annotations
    @annotations.index
  end

  # DELETE /annotations/1
  # DELETE /annotations/1.json
  def destroy
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:slide_id])
    @annotation = @slide.annotations.find(params[:id])
    authorize! :destroy, @annotation
    @annotation.destroy

    respond_to do |format|
      format.html { redirect_to slideset_slide_path(@slideset, @slide) }
      format.json { head :no_content }
    end
  end

  def mark_deleted
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:slide_id])
    @annotation = @slide.annotations.find(params[:id])
    authorize! :mark_deleted, @annotation
    @annotation.deleted = true
    @annotation.last_author = current_user
    respond_to do |format|
      if @annotation.save
        format.html { redirect_to slideset_slide_path(@slideset, @slide), notice: "Die Annotation \"#{@annotation.annotation}\" wurde erfolgreich gelöscht" }
        format.json { render json: @annotation, status: :created, location: @annotation }
      else
        format.html { redirect_to slideset_slide_path(@slideset, @slide) }
        format.json { render json: @annotation.errors, status: :unprocessable_entity }
      end
    end
  end

  def unmark_deleted
    @slideset = Slideset.find(params[:slideset_id])
    @slide = @slideset.slides.find(params[:slide_id])
    @annotation = @slide.annotations.find(params[:id])
    authorize! :unmark_deleted, @annotation
    @annotation.deleted = false
    @annotation.last_author = current_user

    respond_to do |format|
      if @annotation.save
        format.html { redirect_to slideset_slide_path(@slideset, @slide), notice: "Die Annotation \"#{@annotation.annotation}\" wurde erfolgreich wiederhergestellt" }
        format.json { render json: @annotation, status: :created, location: @annotation }
      else
        format.html { redirect_to slideset_slide_path(@slideset, @slide) }
        format.json { render json: @annotation.errors, status: :unprocessable_entity }
      end
    end
  end
end

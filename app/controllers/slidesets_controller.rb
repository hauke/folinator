# -*- encoding : utf-8 -*-
class SlidesetsController < ApplicationController
  # GET /slidesets/new
  # GET /slidesets/new.json
  def new
    authorize! :create, build_resource

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: resource }
    end
  end

  # GET /slidesets/1/edit
  def edit
    authorize! :update, resource
    @lecture = resource.lecture
  end

  # POST /slidesets
  # POST /slidesets.json
  def create
    authorize! :create, build_resource

    respond_to do |format|
      if resource.save
        format.html { redirect_to lecture_path(@lecture), notice: 'Slideset was successfully created.' }
        format.json { render json: resource, status: :created, location: resource }
      else
        format.html { render action: "new" }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /slidesets/1
  # PUT /slidesets/1.json
  def update
    authorize! :update, resource

    respond_to do |format|
      if resource.update_attributes(params[:slideset])
        format.html { redirect_to slideset_slides_path(resource), notice: 'Slideset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slidesets/1
  # DELETE /slidesets/1.json
  def destroy
    authorize! :destroy, resource
    @lecture = resource.lecture
    resource.destroy

    respond_to do |format|
      format.html { redirect_to lecture_path(@lecture) }
      format.json { head :no_content }
    end
  end

  def mark_deleted
    authorize! :mark_deleted, resource
    @lecture = resource.lecture
    resource.deleted = true

    respond_to do |format|
      if resource.save
        format.html { redirect_to lecture_path(@lecture), notice: "Der Foliensatz \"#{resource.title}\" wurde erfolgreich ausgeblendet" }
        format.json { render json: resource, status: :created, location: resource }
      else
        format.html { redirect_to lecture_path(@lecture) }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def unmark_deleted
    authorize! :unmark_deleted, resource
    @lecture = resource.lecture
    resource.deleted = false

    respond_to do |format|
      if resource.save
        format.html { redirect_to lecture_path(@lecture), notice: "Der Foliensatz \"#{resource.title}\" wurde erfolgreich eingeblendet" }
        format.json { render json: resource, status: :created, location: resource }
      else
        format.html { redirect_to lecture_path(@lecture) }
        format.json { render json: resource.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
    authorize! :show, resource
    @slides = resource.slides.available
    
    respond_to do |format|
      format.pdf {
        prawnto :prawn => {
            page_size: 'A4',
            margin: 0,
            :info => {
              :Title => "#{resource.lecture.title} | #{resource.title}",
              :Producer => "Folinator",
              :Creator => "Folinator",
              :CreationDate => Time.now
            }
          },
          :filename => "#{resource.title}.pdf",
          :inline => false
        render :layout => false
      }
    end
  end
  
  protected
  

  def resource
    @slideset ||= end_of_association_chain.find(params[:id])
  end
  
  def build_resource
    @lecture  ||= Lecture.find(params[:lecture_id])
    @slideset ||= @lecture.slidesets.build(params[:slideset])
  end
  
  def end_of_association_chain
    scope = Slideset
    scope = scope.available unless is_admin
    scope
  end
  
  def collection
    @slidesets ||= end_of_association_chain.all
  end
  
end

# -*- encoding : utf-8 -*-
class LecturesController < ApplicationController
  # GET /lectures
  # GET /lectures.json
  def index
    @lectures = end_of_association_chain.all
    authorize! :read,  @lectures

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @lectures }
    end
  end

  # GET /lectures/1
  # GET /lectures/1.json
  def show
    authorize! :read, resource
    
    @slidesets = resource.slidesets
    @slidesets = @slidesets.available unless is_admin

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @lecture }
    end
  end

  # GET /lectures/new
  # GET /lectures/new.json
  def new
    @lecture = Lecture.new
    authorize! :create,  @lecture

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @lecture }
    end
  end

  # GET /lectures/1/edit
  def edit
    authorize! :update, resource
  end

  # POST /lectures
  # POST /lectures.json
  def create
    @lecture = Lecture.new(params[:lecture])
    authorize! :create,  @lecture

    respond_to do |format|
      if @lecture.save
        format.html { redirect_to @lecture, notice: 'Lecture was successfully created.' }
        format.json { render json: @lecture, status: :created, location: @lecture }
      else
        format.html { render action: "new" }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /lectures/1
  # PUT /lectures/1.json
  def update
    authorize! :update, resource

    respond_to do |format|
      if @lecture.update_attributes(params[:lecture])
        format.html { redirect_to @lecture, notice: 'Lecture was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /lectures/1
  # DELETE /lectures/1.json
  def destroy
    authorize! :delete, resource
    resource.destroy

    respond_to do |format|
      format.html { redirect_to lectures_url }
      format.json { head :no_content }
    end
  end

  def mark_deleted
    authorize! :mark_deleted, resource
    resource.deleted = true

    respond_to do |format|
      if @lecture.save
        format.html { redirect_to lectures_path, notice: "Die Vorlesung \"#{@lecture.title}\" wurde erfolgreich ausgeblendet" }
        format.json { render json: @lecture, status: :created, location: @lecture }
      else
        format.html { redirect_to lectures_path }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end

  def unmark_deleted
    authorize! :unmark_deleted, resource
    resource.deleted = false

    respond_to do |format|
      if @lecture.save
        format.html { redirect_to lectures_path, notice: "Die Vorlesung \"#{@lecture.title}\" wurde erfolgreich eingeblendet" }
        format.json { render json: @lecture, status: :created, location: @lecture }
      else
        format.html { redirect_to lectures_path }
        format.json { render json: @lecture.errors, status: :unprocessable_entity }
      end
    end
  end
  
  protected
  
  def end_of_association_chain
    chain = Lecture
    chain = chain.available unless is_admin
    chain
  end
  
  def resource
    @lecture ||= end_of_association_chain.find(params[:id])
  end
  
end

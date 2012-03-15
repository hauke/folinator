# -*- encoding : utf-8 -*-
class SlidesetsController < ApplicationController
  # GET /slidesets/new
  # GET /slidesets/new.json
  def new
    @lecture = Lecture.find(params[:lecture_id])
    @slideset = @lecture.slidesets.new
    authorize! :create, @slideset

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slideset }
    end
  end

  # GET /slidesets/1/edit
  def edit
    @slideset = Slideset.find(params[:id])
    authorize! :update, @slideset
    @lecture = @slideset.lecture
  end

  # POST /slidesets
  # POST /slidesets.json
  def create
    @lecture = Lecture.find(params[:lecture_id])
    @slideset = @lecture.slidesets.new(params[:slideset])
    authorize! :create, @slideset

    respond_to do |format|
      if @slideset.save
        format.html { redirect_to lecture_path(@lecture), notice: 'Slideset was successfully created.' }
        format.json { render json: @slideset, status: :created, location: @slideset }
      else
        format.html { render action: "new" }
        format.json { render json: @slideset.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /slidesets/1
  # PUT /slidesets/1.json
  def update
    @slideset = Slideset.find(params[:id])
    authorize! :update, @slideset

    respond_to do |format|
      if @slideset.update_attributes(params[:slideset])
        format.html { redirect_to slideset_slides_path(@slideset), notice: 'Slideset was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @slideset.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /slidesets/1
  # DELETE /slidesets/1.json
  def destroy
    @slideset = Slideset.find(params[:id])
    @lecture =  @slideset.lecture
    authorize! :destroy, @slideset
    @slideset.destroy

    respond_to do |format|
      format.html { redirect_to lecture_path(@lecture) }
      format.json { head :no_content }
    end
  end

  def mark_deleted
    @slideset = Slideset.find(params[:id])
    @lecture = @slideset.lecture
    authorize! :mark_deleted, @slideset
    @slideset.deleted = true

    respond_to do |format|
      if @slideset.save
        format.html { redirect_to lecture_path(@lecture), notice: "Der Foliensatz \"#{@slideset.title}\" wurde erfolgreich ausgeblendet" }
        format.json { render json: @slideset, status: :created, location: @slideset }
      else
        format.html { redirect_to lecture_path(@lecture) }
        format.json { render json: @slideset.errors, status: :unprocessable_entity }
      end
    end
  end

  def unmark_deleted
    @slideset = Slideset.find(params[:id])
    @lecture = @slideset.lecture
    authorize! :unmark_deleted, @slideset
    @slideset.deleted = false

    respond_to do |format|
      if @slideset.save
        format.html { redirect_to lecture_path(@lecture), notice: "Der Foliensatz \"#{@slideset.title}\" wurde erfolgreich eingeblendet" }
        format.json { render json: @slideset, status: :created, location: @slideset }
      else
        format.html { redirect_to lecture_path(@lecture) }
        format.json { render json: @slideset.errors, status: :unprocessable_entity }
      end
    end
  end
end

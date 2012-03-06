class SlidesetsController < ApplicationController
  # GET /slidesets
  # GET /slidesets.json
  def index
    @slidesets = Slideset.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @slidesets }
    end
  end

  # GET /slidesets/1
  # GET /slidesets/1.json
  def show
    @slideset = Slideset.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @slideset }
    end
  end

  # GET /slidesets/new
  # GET /slidesets/new.json
  def new
    @slideset = Slideset.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slideset }
    end
  end

  # GET /slidesets/1/edit
  def edit
    @slideset = Slideset.find(params[:id])
  end

  # POST /slidesets
  # POST /slidesets.json
  def create
    @slideset = Slideset.new(params[:slideset])

    respond_to do |format|
      if @slideset.save
        format.html { redirect_to @slideset, notice: 'Slideset was successfully created.' }
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

    respond_to do |format|
      if @slideset.update_attributes(params[:slideset])
        format.html { redirect_to @slideset, notice: 'Slideset was successfully updated.' }
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
    @slideset.destroy

    respond_to do |format|
      format.html { redirect_to slidesets_url }
      format.json { head :no_content }
    end
  end
end

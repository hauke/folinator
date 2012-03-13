class SlidesetsController < ApplicationController
  # GET /slidesets/new
  # GET /slidesets/new.json
  def new
    @slideset = Slideset.new
    authorize! :create, @slideset
    @lecture = @slideset.lecture

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @slideset }
    end
  end

  # GET /slidesets/1/edit
  def edit
    @slideset = Slideset.find(params[:id])
    authorize! :update, @slideset
  end

  # POST /slidesets
  # POST /slidesets.json
  def create
    @slideset = Slideset.new(params[:slideset])
    authorize! :create, @slideset

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
    authorize! :update, @slideset

    respond_to do |format|
      if @slideset.update_attributes(params[:slideset])
        format.html { redirect_to slidesets_path, notice: 'Slideset was successfully updated.' }
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
    authorize! :destroy, @slideset
    @slideset.destroy

    respond_to do |format|
      format.html { redirect_to slidesets_url }
      format.json { head :no_content }
    end
  end
end

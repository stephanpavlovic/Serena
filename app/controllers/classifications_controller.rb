class ClassificationsController < ApplicationController
  # GET /classifications
  # GET /classifications.xml
  def index
   @concepts = Classification.find
  end

  # GET /classifications/1
  # GET /classifications/1.xml
  def show
    @classification = Classification.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @classification }
    end
  end

  # GET /classifications/new
  # GET /classifications/new.xml
  def new
    @classification = Classification.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @classification }
    end
  end

  # GET /classifications/1/edit
  def edit
    @classification = Classification.find(params[:id])
  end

  # POST /classifications
  # POST /classifications.xml
  def create
    @classification = Classification.new(params[:classification])

    respond_to do |format|
      if @classification.save
        flash[:notice] = 'Classification was successfully created.'
        format.html { redirect_to(@classification) }
        format.xml  { render :xml => @classification, :status => :created, :location => @classification }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @classification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /classifications/1
  # PUT /classifications/1.xml
  def update
    @classification = Classification.find(params[:id])

    respond_to do |format|
      if @classification.update_attributes(params[:classification])
        flash[:notice] = 'Classification was successfully updated.'
        format.html { redirect_to(@classification) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @classification.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /classifications/1
  # DELETE /classifications/1.xml
  def destroy
    @classification = Classification.find(params[:id])
    @classification.destroy

    respond_to do |format|
      format.html { redirect_to(classifications_url) }
      format.xml  { head :ok }
    end
  end
end

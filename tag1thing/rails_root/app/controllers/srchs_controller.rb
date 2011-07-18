class SrchsController < ApplicationController
  # GET /srchs
  # GET /srchs.xml
  def index
    @srchs = Srch.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @srchs }
    end
  end

  # GET /srchs/1
  # GET /srchs/1.xml
  def show
    @srch = Srch.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @srch }
    end
  end

  # GET /srchs/new
  # GET /srchs/new.xml
  def new
    @srch = Srch.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @srch }
    end
  end

  # GET /srchs/1/edit
  def edit
    @srch = Srch.find(params[:id])
  end

  # POST /srchs
  # POST /srchs.xml
  def create
    @srch = Srch.new(params[:srch])

    respond_to do |format|
      if @srch.save
        flash[:notice] = 'Srch was successfully created.'
        format.html { redirect_to(@srch) }
        format.xml  { render :xml => @srch, :status => :created, :location => @srch }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @srch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /srchs/1
  # PUT /srchs/1.xml
  def update
    @srch = Srch.find(params[:id])

    respond_to do |format|
      if @srch.update_attributes(params[:srch])
        flash[:notice] = 'Srch was successfully updated.'
        format.html { redirect_to(@srch) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @srch.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /srchs/1
  # DELETE /srchs/1.xml
  def destroy
    @srch = Srch.find(params[:id])
    @srch.destroy

    respond_to do |format|
      format.html { redirect_to(srchs_url) }
      format.xml  { head :ok }
    end
  end
end

class ThngsController < ApplicationController
  # GET /thngs
  # GET /thngs.xml
  def index
    @thngs = Thng.paginate(:all, :page => params[:page], :order => 'updated_at DESC')

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @thngs }
    end
  end

  # GET /thngs/1

  def collect4show
    @tagnms= []
    @imgsrcs= []
    @vhtmls= []
    @hhrefs= []
    @cmmntxts= []
    @thng.tags.uniq.each{  |tag|   @tagnms<<   tag.tagnm       unless ( tag.tagnm.nil?      or tag.tagnm== "")       }
    @thng.iimgs.uniq.each{ |iimg|  @imgsrcs<<  iimg.imgsrc     unless ( iimg.imgsrc.nil?    or iimg.imgsrc== "")     }
    @thng.videos.uniq.each{|video| @vhtmls<<   video.videohtml unless (video.videohtml.nil? or video.videohtml== "") } 
    @thng.uurls.uniq.each{ |uurl|  @hhrefs<<   uurl.hhref      unless ( uurl.hhref.nil?     or uurl.hhref== "")      }
    @thng.cmmnts.uniq.each{|cmmnt| @cmmntxts<< cmmnt.cmmntxt   unless (cmmnt.cmmntxt.nil?   or cmmnt.cmmntxt== "")   } 
  end

  def show2col
  end

  # GET /thngs/1.xml
  def show
    @thng= Thng.find(params[:id])
    collect4show
    render :action => "show2col"
  end

  def shrturl_show
    @thng= Thng.find_by_shrturl params["shrturl"]
    # Publicize a new thng unless this thng exists.
    (redirect_to(:action => "publicize", :shrturl => "#{params['shrturl']}"); return) unless(@thng)
    # The thng exists, let us show it.
    collect4show
    if(@thng.layouttf== true)
      render :action => "just_thngdsc", :layout => "nada"
    else
      render :action => "show2col"
    end
  end # def shrturl_show

  def just_thngdsc
  end

  # GET /thngs/new
  # GET /thngs/new.xml
  def new
    @thng = Thng.new
    @frqtags_from_db= Frqtag.find :all
    @frqtags3= @frqtags_from_db.map{ |t| "<option>#{t.tgnm}</option>" }.to_s
    @frqtags1= "<option>My thing</option> " + @frqtags3
    @frqtags2= "<option>No 2nd tag needed</option> " + @frqtags3

    # Fill objects with blanks so I can share code among haml files.
    @tagnms    = [1,2,3,4].map{ |i| ""}
    @hhrefs    = [1,2,3,4].map{ |i| ""}
    @imgsrcs   = [1,2,3,4].map{ |i| ""}
    @videohtmls= [1,2,3,4].map{ |i| ""}
  end

  def memorize
    new
  end

  def publicize
    new
  end

  def newfast
    new
  end

  # GET /thngs/1/edit
  def edit
    # @thng = Thng.find(params[:id])
    @thng= Usr.find_by_opndd(session[:opndd]).thngs.find(params[:id])
  end

  # GET /thngs/1/editem
  def editem
    # @thng = Thng.find(params[:id])
    @thng= Usr.find_by_opndd(session[:opndd]).thngs.find(params[:id])

    @tagnms=     [0] # helps me start counting at 1 in the view
    @videohtmls= [0] 
    @hhrefs=     [0] 
    @imgsrcs=    [0] 

    if @thng.tags.nil?
      [1,2,3,4].each{ |i| @tagnms<< ""} # if tags.nil? the view wants blanks
    else
      @thng.tags.each{ |tag| @tagnms<< tag.tagnm }
    end

    if @thng.iimgs.nil?
      [1,2,3,4].each{ |i| @imgsrcs<< ""} # if iimgs.nil? the view wants blanks
    else
      @thng.iimgs.each{ |iimg| @imgsrcs<< iimg.imgsrc }
    end

    if @thng.uurls.nil?
      [1,2,3,4].each{ |i| @hhrefs<< ""} # if uurs.nil? the view wants blanks
    else
      @thng.uurls.each{ |uurl| @hhrefs<< uurl.hhref }
    end

    if @thng.videos.nil?
      [1,2,3,4].each{ |i| @videohtmls<< ""} # if videohtmls.nil? the view wants blanks
    else
      @thng.videos.each{ |video| @videohtmls<< video.videohtml }
    end

    # put plenty of blanks at the end
    [1,2,3,4].each{ |i| @tagnms<< ""} 
    [1,2,3,4].each{ |i| @hhrefs<< ""} 
    [1,2,3,4].each{ |i| @imgsrcs<< ""} 
    [1,2,3,4].each{ |i| @videohtmls<< ""} 

  end # def editem

  # updatem is the Action of editem/1
  # updatem is similar to createm
  def updatem
    # @thng = Thng.find(params[:id])
    @thng = Usr.find_by_opndd(session[:opndd]).thngs.find(params[:id])
    # Update is difficult so I will do DELETE/INSERT
    Iimg.destroy_all(:thng_id => @thng.id)
    Tag.destroy_all(:thng_id => @thng.id)
    Uurl.destroy_all(:thng_id => @thng.id)
    Video.destroy_all(:thng_id => @thng.id)

    [0,1,2,3].each{ |arn|
      @thng.iimgs<< Iimg.new()
      @thng.tags<< Tag.new()
      @thng.uurls<< Uurl.new()
      @thng.videos<< Video.new()
    }
    # Copy data from form into controller
    [0,1,2,3].each{ |arn|
      pnum= (arn+ 1).to_s
      @thng.iimgs[arn].imgsrc    = params["thng_img#{pnum}"]
      @thng.tags[arn].tagnm      = params["thng_tag#{pnum}"]
      @thng.uurls[arn].hhref     = params["thng_url#{pnum}"]
      @thng.videos[arn].videohtml= params["thng_video#{pnum}"]
    }
    # Maybe a new cmmnt has been added
    unless (params["thng_cmmntxt"].nil? or params["thng_cmmntxt"]== "")
      Cmmnt.create( :cmmntxt => params["thng_cmmntxt"], :thng => @thng )
    end
    # All my objects are wired up. Nuke nils
    (@thng.iimgs).delete_if{ |ar| ar.imgsrc== ""    }
    (@thng.tags).delete_if{  |ar| ar.tagnm== ""     }
    (@thng.uurls).delete_if{ |ar| ar.hhref== ""     }
    (@thng.videos).delete_if{|ar| ar.videohtml== "" }
    # All my objects are wired up. Send data to the DB
    (@thng.iimgs).flatten.uniq.each{ |ar| ar.save unless (ar.nil? or ar.imgsrc== "")   }
    (@thng.tags).flatten.uniq.each{  |ar| ar.save unless (ar.nil? or ar.tagnm== "")    }
    (@thng.uurls).flatten.uniq.each{ |ar| ar.save unless (ar.nil? or ar.hhref== "")    }
    (@thng.videos).flatten.uniq.each{|ar| ar.save unless (ar.nil? or ar.videohtml== "")}
    respond_to do |format|
      if @thng.update_attributes(params[:thng])
        flash[:notice] = "Your Thing was updated.<br />"
        flash[:notice]<< "The Short URL of Your Thing: <br />"
        flash[:notice]<< "<a href='http://t1t.us/#{@thng.shrturl}'>http://t1t.us/#{@thng.shrturl}</a>"
        format.html { redirect_to(@thng) }
        format.xml  { head :ok }
      else
        format.html { render :action => "editem" }
        format.xml  { render :xml => @thng.errors, :status => :unprocessable_entity }
      end
    end
  end #   def updatem


  # POST /thngs
  # POST /thngs.xml
  def create
    @thng = Thng.new(params[:thng])
    @thng.usr= Usr.find_by_opndd(session[:opndd]) unless session[:opndd].nil?
    respond_to do |format|
      if @thng.save
        flash[:notice] = 'Thng was successfully created.'
        format.html { redirect_to(@thng) }
        format.xml  { render :xml => @thng, :status => :created, :location => @thng }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @thng.errors, :status => :unprocessable_entity }
      end
    end
  end

  def createm
    # Get a usr_id (or 1 which is the usr_id of Guest)
    @usr= Usr.new
    case
    when session[:opndd].nil?
      @usr_id= 1
    when (@usr= Usr.find_by_opndd(session[:opndd])).nil?
      @usr_id= 1
    else
      @usr_id= @usr.id
    end # case

    @thng = Thng.new(params[:thng])
    @thng.usr_id= @usr_id

    # Here is info from a param list:
    # "thng"=>{"thngnm"=>"It", "thngdsc"=>"", "thngwhy"=>""}
    # "thng_url4"=>""
    # "thng_img4"=>""
    # "thng_video4"=>""

    @ar_objects= []
    %w[1 2 3 4].each{ |p| 
      unless (params["thng_tag#{p}"].nil? or params["thng_tag#{p}"]== "" or params["thng_tag#{p}"]== "No 2nd tag needed")
        @ar_objects<< Tag.new(:tagnm =>     params["thng_tag#{p}"])
      end
      @ar_objects<< Uurl.new(:hhref =>      params["thng_url#{p}"])  unless(params["thng_url#{p}"].nil?   or params["thng_url#{p}"]== ""  )
      @ar_objects<< Video.new(:videohtml => params["thng_video#{p}"])unless(params["thng_video#{p}"].nil? or params["thng_video#{p}"]== "")
      @ar_objects<< Iimg.new(:imgsrc =>     params["thng_img#{p}"])  unless(params["thng_img#{p}"].nil?   or params["thng_img#{p}"]== ""  )

      }
    @ar_objects.each{ |ar| ar.thng= @thng}

    ([@thng] + @ar_objects).flatten.uniq.each{ |ar| ar.save unless ar.nil? }
  end # def createm

  def createm4publicize
    createm
    flash_shrturl
    redirect_to :action => :publicize
  end

  def flash_shrturl
    flash[:notice] = "Your Thing was Memorized then Publicized!<br />"
    flash[:notice]<< "The Short URL of Your Thing: <br />"
    flash[:notice]<< "<a href='http://t1t.us/#{@thng.shrturl}'>http://t1t.us/#{@thng.shrturl}</a>"
  end

  def createm4memorize
    createm
    flash[:notice] = "Your Thing was Memorized!<br />"
    flash[:notice]<< "The Short URL of Your Thing: <br />"
    flash[:notice]<< "<a href='http://t1t.us/#{@thng.shrturl}'>http://t1t.us/#{@thng.shrturl}</a>"
    redirect_to :action => :memorize
  end


  # PUT /thngs/1
  # PUT /thngs/1.xml
  def update
    # @thng = Thng.find(params[:id])
    @thng = Usr.find_by_opndd(session[:opndd]).thngs.find(params[:id])
    respond_to do |format|
      if @thng.update_attributes(params[:thng])
        flash[:notice] = 'Thng was successfully updated.'
        format.html { redirect_to(@thng) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @thng.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /thngs/1
  # DELETE /thngs/1.xml
  def destroy
    # @thng = Thng.find(params[:id])
    # @thng = Usr.find_by_opndd(session[:opndd]).thngs.find(params[:id])
    # @thng.destroy unless @thng.nil?
    flash[:notice] = "In this site, a Thing cannot be removed."

    respond_to do |format|
      format.html { redirect_to(thngs_url) }
      format.xml  { head :ok }
    end
  end
end

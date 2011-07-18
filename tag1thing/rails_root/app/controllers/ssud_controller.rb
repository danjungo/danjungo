class SsudController < ApplicationController
  def uupload
    # Make a count of thngs before we get started
    @thngcnt1= Thng.count
    @usr= Usr.find_by_opndd session[:opndd]
    @astring= ""
    llines= []
    plines= []
#    params["file"].each{ |l| @astring<< l}

    # Read the csv-file.  Use it to fill llines-1D-array of strings.
    params["file"].each{ |l| llines<< l if(l =~ /name.+tag1/) }
    ddelnil!(llines)
    # Build plines-2D-array from llines-1D-array using fastercsv-gem
    llines.each{ |l|
      pl= FasterCSV.parse(l).flatten
      ddelnil!(pl)
      plines<< pl if(pl[0] =~ /=/)
    }

    ddelnil!(plines)

    plines.each{ |pl|
      thngnm= gtmem(pl, "name")
      tag1=   gtmem(pl, "tag1")
      tag2=   gtmem(pl, "tag2")
      tag3=   gtmem(pl, "tag3")
      tag4=   gtmem(pl, "tag4")
      url1=   gtmem(pl, "url1")
      url2=   gtmem(pl, "url2")
      url3=   gtmem(pl, "url3")
      url4=   gtmem(pl, "url4")
      desc=   gtmem(pl, "desc")
      why=    gtmem(pl, "why")
      wwhen=  gtmem(pl, "when")

      thng= Thng.new(:thngnm => thngnm, :thngdsc => desc, :thngwhen => wwhen, :thngwhy => why, :usr => @usr) if(thngnm)
      thng.tags<< Tag.new(:tagnm => tag1) if(tag1)
      thng.tags<< Tag.new(:tagnm => tag2) if(tag2)
      thng.tags<< Tag.new(:tagnm => tag3) if(tag3)
      thng.tags<< Tag.new(:tagnm => tag4) if(tag4)

      thng.uurls<< Uurl.new(:hhref => url1) if(url1)
      thng.uurls<< Uurl.new(:hhref => url2) if(url2)
      thng.uurls<< Uurl.new(:hhref => url3) if(url3)
      thng.uurls<< Uurl.new(:hhref => url4) if(url4)

      ([thng]+ thng.tags+ thng.uurls).flatten.each{ |ar| ar.save }

      # Next add usr_id to the ar objects and save them
      (thng.tagthngs+ thng.uurlthngs).flatten.each{ |aro| aro.usr= @usr; aro.save}
    }
    @thngcnt2= Thng.count
    @astring= "<span class='tagnm'>#{(@thngcnt2- @thngcnt1).to_s} </span> Things created!"
  end # def uupload

  # Pluck members out of arry= ['m1=duck', 'mx=cat', 'mm=dog']
  # gtmem(arry, "mx")
  # => "cat"
  def gtmem(arry,mem)
    rg= %r{(#{mem}=)(.+)}
    arry.each{ |m| 
      memout= m.scan(rg).flatten[1]
      return memout unless memout.nil?
    }
    return nil
  end # def gtmem(arry,mem)


  def ddownload
    @usr= Usr.find_by_opndd session[:opndd]
#    @thngs= Thng.paginate_by_usr_id(@usr.id, :page => params[:page])
    @thngs= @usr.thngs.paginate(:page => params[:page], :order => 'updated_at DESC')
    render :layout => "nada"
  end


end

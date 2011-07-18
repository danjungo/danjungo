class SsearchController < ApplicationController
  def index
  end

  def bytag
    @thngs= @tag.thngs unless(@tag= Tag.find_by_tagnm params[:bytag]).nil?
    if @tag.nil?
      flash[:notice]= "No Things connected to tag: <span style='color: black;'>#{params[:bytag]}</span>. Maybe, try a different tag."
      redirect_to :action => "form4tag"
    end # if
  end # def bytag

  def byurl
    if (@uurls= Uurl.find(:all, :conditions => ['hhref LIKE ?', "%#{params[:byurl]}%"])).nil?
      flash[:notice]= "No Things connected to URL: <span style='color: black;'>#{params[:byurl]}</span>. Maybe, try a different URL."
      redirect_to :action => "form4url"
    else
      @thngs=  []
      @hhrefs= []
      @uurls.each{ |uurl| @hhrefs<< uurl.hhref }
      @uurls.each{ |uurl| @thngs<<  uurl.thngs unless (uurl.nil? or uurl.thngs.nil?) }
    end # if
  end # def byurl

  def bydesc
    if (@thngs= Thng.find(:all, :conditions => ['thngdsc LIKE ?', "%#{params[:bydesc]}%"])).size== 0
      flash[:notice]= "No Things have a description containing Search-Term: <span style='color: black;'>#{params[:bydesc]}</span>. Maybe, try a different Search-Term."
      redirect_to :action => "form4desc"
    else
      # nada
    end # if
  end

  def byusr
#    if (@usrs= Usr.find_by_usrnm params[:byusr]).nil?
    if (@usrs= Usr.find(:all, :conditions => ['usrnm = ?', "#{params[:byusr]}" ])).size== 0
      flash[:notice]= "No Things match Username: <span style='color: black;'>#{params[:byusr]}</span>. Maybe, try a different Username."
      redirect_to :action => "form4usr"
    else
      @thngs= []
      @usrs.each{ |usr| @thngs<< usr.thngs }
    end # if

  end
  def advsearch

#    @thngs= Thng.find(:all, :conditions => ['id = ?', "1"])
    sel= "SELECT distinct id,thngnm FROM adv "
    where= "WHERE tagnm = ? "
    andusr= "AND usrnm = ? "
    andurl= "AND hhref LIKE ? "
    anddsc= "AND thngdsc LIKE ? "
    sql= sel+where+andusr+andurl+anddsc
    @thngs= Thng.find_by_sql [sql, params[:bytag],params[:byusr], "%#{params[:byurl]}%","%#{params[:bydesc]}%"]
  end

end

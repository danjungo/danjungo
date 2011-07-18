# Demonstrates some Hpricot functionality

class DemosController < ApplicationController

  # Open this controller to the world
  skip_before_filter :authenticate_usr

  # Wraps hpricot_object.search(searchexpr).to_html
  def search
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    @hpexpr = 'hpricot_object.search(' + '"' + searchexpr + '"' + ').to_html'
    hpricot_object = get_my_hp_elem(@uurl)
    @myhtml = hpricot_object.search(searchexpr).to_html
    render(:layout => "nada", :action => "demoout")
  end # search

  # Wraps hpricot_object.to_html after hpricot_object.search(searchexpr).remove
  def search_remove
    @uurl = params[:uurl]
    searchexpr = params[:hpexpr]
    @hpexpr = 'hpricot_object.search(' + '"' + searchexpr + '"' + ').remove'
    hpricot_object = get_my_hp_elem(@uurl)
    hpricot_object.search(searchexpr).remove
    @myhtml = hpricot_object.to_html
    render(:layout => "nada", :action => "demoout")
  end # search_remove

  # Wraps hpricot_object.search(s1expr).search(s2expr).to_html
  def search_search
    @uurl = params[:uurl]
    s1expr = params[:s1expr]
    s2expr = params[:s2expr]
    @hpexpr = 'hpricot_object.search(' + '"' + s1expr + '"' + ').search(' + '"' + s2expr + '"' + ').to_html'
    hpricot_object = get_my_hp_elem(@uurl)
    @myhtml = hpricot_object.search(s1expr).search(s2expr)
    render(:layout => "nada", :action => "demoout")
  end # search_search

  # Wraps hpricot_object.at(atexpr).to_html
  def at
    @uurl = params[:uurl]
    atexpr = params[:atexpr]
    hpricot_object = get_my_hp_elem(@uurl)
    @hpexpr = 'hpricot_object.at(' + '"' + atexpr + '"' + ').to_html'
    @myhtml = hpricot_object.at(atexpr).to_html
    render(:layout => "nada", :action => "demoout")
  end # at

  # Wraps hpricot_object.search(innerhtmlexpr).inner_html
  def innerhtml
    @uurl = params[:uurl]
    innerhtmlexpr = params[:innerhtmlexpr]
    hpricot_object = get_my_hp_elem(@uurl)
    @hpexpr = 'hpricot_object.at(' + '"' + innerhtmlexpr + '"' + ').inner_html'
    @myhtml = hpricot_object.at(innerhtmlexpr).inner_html
    render(:layout => "nada", :action => "demoout")
  end # innerhtml

  # Wraps hpricot_object.search(searchexpr).first.to_html
  def search_first
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    @hpexpr = 'hpricot_object.search(' + '"' + searchexpr + '"' + ').first.to_html'
    hpricot_object = get_my_hp_elem(@uurl)
    @myhtml = hpricot_object.search(searchexpr).first.to_html
    render(:layout => "nada", :action => "demoout")
  end # search_first


  # Wraps hpricot_object.search(searchexpr).map {|e| "<hr />#{e.to_html}" }.sort.to_s
  def search_map
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    @hpexpr = 'hpricot_object.search(' + '"' + searchexpr + '"' + ').map {|e| "<hr />#{e.to_html}" }.sort.to_s'
    @hpexpr = h(@hpexpr)
    hpricot_object = get_my_hp_elem(@uurl)
    @myhtml = hpricot_object.search(searchexpr).map {|e| "<hr />#{e.to_html}" }.sort.to_s
    render(:layout => "nada", :action => "demoout")
  end # search_map

  # Wraps hpricot_object.search(searchexpr).prepend("<hr />")
  def search_prepend
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    @hpexpr = 'hpricot_object.search(' + '"' + searchexpr + '"' + ').prepend("<hr />").to_html'
    @hpexpr = h(@hpexpr)
    hpricot_object = get_my_hp_elem(@uurl)
    @myhtml = hpricot_object.search(searchexpr).prepend("<hr />").to_html
    render(:layout => "nada", :action => "demoout")
  end # search_prepend

  # Wraps hpricot_object.search(searchexpr).wrap("<h1>")
  def search_wrap
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    @hpexpr = 'hpricot_object.search(' + '"' + searchexpr + '"' + ').search("..").to_html'
    @hpexpr = h(@hpexpr)
    hpricot_object = get_my_hp_elem(@uurl)
    hpricot_object.search(searchexpr).wrap("<h1>")
    @myhtml = hpricot_object.search(searchexpr).search("..").to_html
    render(:layout => "nada", :action => "demoout")
  end # search_wrap

  # Wraps hpricot_object.at().swap()
  def search_swap
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    parentsearchexpr = params[:parentsearchexpr]
    @hpexpr = 'hpricot_object.at(' + '"' + searchexpr + '"' + ').swap("<h1>hpricot.com</h1>")'
    @hpexpr = h(@hpexpr)
    hpricot_object = get_my_hp_elem(@uurl)
    hpricot_object.at(searchexpr).swap("<h1>hpricot.com</h1>")
    @myhtml = hpricot_object.search(parentsearchexpr).to_html
    render(:layout => "nada", :action => "demoout")
  end # search_swap

  # Wraps hpricot_object.search().map {|e| '<hr />' + e.get_attribute(#{attrname}) }.sort.to_s
  def search_attributes
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    attrname =   params[:attrname]
    @hpexpr = "hpricot_object.search(#{searchexpr}).map {|e| '<hr />' + e.get_attribute(#{attrname}) }.sort.to_s"
    @hpexpr = h(@hpexpr)
    hpricot_object = get_my_hp_elem(@uurl)
    @myhtml = hpricot_object.search(searchexpr).map {|e| "<hr />" + e.get_attribute(attrname) }.sort.to_s
    render(:layout => "nada", :action => "demoout")
  end # search_attributes

  # Wraps hpricot_object.search().map{}.to_s
  def disp_enum
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    @hpexpr = 'i = -1; hpricot_object.search(' + '"' + searchexpr + '"' + ').map{|e| i+=1;"<hr />#{i}#{e}"}.to_s'
    @hpexpr = h(@hpexpr)
    hpricot_object = get_my_hp_elem(@uurl)
    i = -1; @myhtml = hpricot_object.search(searchexpr).map{|e| i+=1;"<hr />#{i} #{e}"}.to_s
    render(:layout => "nada", :action => "demoout")
  end # disp_enum

  # Wraps hpricot_object.search().map{}.slice().to_s
  def disp_enum_slice
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    arg1= params[:arg1].to_i
    arg2= params[:arg2].to_i
    @hpexpr = 'i = -1; hpricot_object.search(' + '"' + searchexpr + '"' + ').map{|e| i+=1;"<hr />#{i}#{e}"}[' + params[:arg1] + ',' + params[:arg2] + '].to_s'
    @hpexpr = h(@hpexpr)
    hpricot_object = get_my_hp_elem(@uurl)
    i = -1; @myhtml = hpricot_object.search(searchexpr).map{|e| i+=1;"<hr />#{i} #{e}"}[arg1, arg2].to_s
    render(:layout => "nada", :action => "demoout")
  end # disp_enum_slice


  # Wraps hpricot_object.search().map{}.to_s
  def disp_comments
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    @hpexpr = 'hpricot_object.search(' + '"' + searchexpr + '"' + ').map......'
    @hpexpr = h(@hpexpr)
    hpricot_object = get_my_hp_elem(@uurl)
    @myhtml = hpricot_object.search(searchexpr).search("*").map{|e| "<hr />#{e}" if e.comment?}.to_s
    render(:layout => "nada", :action => "demoout")
  end # disp_comments

  # Wraps hpricot_object.search().to_html after comments removed
  def remove_comments
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    @hpexpr = 'hpricot_object.search(' + '"' + searchexpr + '"' + ').search("*").each{|e| (lst=e.parent.children;e.parent=nil;lst.delete(e)) if e.comment?}'
    @hpexpr = h(@hpexpr)
    hpricot_object = get_my_hp_elem(@uurl)
    hpricot_object.search(searchexpr).search("*").each{|e| (lst=e.parent.children;e.parent=nil;lst.delete(e)) if e.comment?}
    @myhtml = hpricot_object.search(searchexpr).to_html
    render(:layout => "nada", :action => "demoout")
  end # remove_comments

  # Wraps hpricot_object.search()....
  def text_search_loose
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    @hpexpr = 'hpricot_object.search(' + '"' + searchexpr + '"' + ').to_html'
    @hpexpr = h(@hpexpr)
    hpricot_object = get_my_hp_elem(@uurl)
    @myhtml = hpricot_object.search(searchexpr).to_html
    render(:layout => "nada", :action => "demoout")
  end # text_search_loose

  def text_node_alter
    @uurl = params[:uurl]
    old = params[:oldtext]
    new = params[:newtext]
    @hpexpr = 'hpricot_object.search("*")' + ".each {|e| e.content=e.content().gsub(Regexp.new('#{old}'), '#{new}') if e.text? }"
    @hpexpr = h(@hpexpr)
    hpricot_object = get_my_hp_elem(@uurl)
    hpricot_object.search("*").each {|e| e.content=e.content().gsub(Regexp.new(old), new) if e.text? }
    @myhtml = hpricot_object.to_html
    render(:layout => "nada", :action => "demoout")
  end

  # Wraps hpricot_object.search(searchexpr).remove_attr(attr_name)
  def remove_attr
    @uurl = params[:uurl]
    searchexpr = params[:searchexpr]
    attr_name = params[:attr_name]
    @hpexpr = 'hpricot_object.search(' + '"' + searchexpr + '"' + ').remove_attr(' + '"' + attr_name + '"' + ')'
    hpricot_object = get_my_hp_elem(@uurl)
    hpricot_object.search(searchexpr).remove_attr(attr_name)
    @myhtml = hpricot_object.to_html
    render(:layout => "nada", :action => "demoout")
  end # search

  # Allows me to look at the demoout.haml
  def demoout
    @uurl = "http://www.google.com"
    @hpexpr = "h1"
    @myhtml = "<h1>hello world</h1>"
    render(:layout => "nada", :action => "demoout")
  end # demoout

  # Allows user to see a page full of demo forms
  def index
  end # index

  # About action in the layout
  def about
  end # aboutform

  # Similar to demoout but with the application layout
  def aboutout
    @myhtml = "<h1>hello world</h1>"
    @uurl = params[:uurl]
    @hpexpr = params[:hpexpr]
    hpricot_object = get_my_hp_elem(@uurl)
    @myhtml = hpricot_object.search(@hpexpr).to_html
    render(:layout => "application")
  end # aboutout

  protected
  # nada

end # class

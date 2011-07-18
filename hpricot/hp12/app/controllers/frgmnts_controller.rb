# Provides key functionality of the Workbench.
class FrgmntsController < ApplicationController

  # Repel them if they manually edit the id in request URL
  before_filter :repel_them

  # active_scaffold creates powerful JS based forms.  See http://activescaffold.com
  active_scaffold do |config|
    config.label = "Hpricot Workbench For Building Fragments Of HTML"
    config.list.columns = [:stck, :name, :inputurl, :parent, :exprtype, :arg1, :arg2, :arg3, :arg4, :frgtxt]
    config.show.columns = [:stck, :name, :inputurl, :parent, :exprtype, :arg1, :arg2, :arg3, :arg4, :frgtxt]
    config.create.columns = [:stck, :name, :inputurl, :parent, :exprtype, :arg1, :arg2, :arg3, :arg4]
    config.update.columns = [:stck, :name, :inputurl, :parent, :exprtype, :arg1, :arg2, :arg3, :arg4]

    config.columns[:stck].label = "Stack Name"
    config.columns[:name].label = "Fragment Name"
    config.columns[:parent].label = "Parent Fragment"
    config.columns[:inputurl].label = "Input URL"
    config.columns[:frgtxt].label = "Fragment Text Scraped From Input Source (Parent, or Input URL)"
    config.columns[:exprtype].label = "Type Of Expression"

    columns[:parent].form_ui = :select
    columns[:exprtype].form_ui = :select
    columns[:stck].form_ui = :select

  end # active_scaffold

  protected

  # Only show frgmnts owned by the usr in the current session
  def conditions_for_collection
    ['frgmnts.usr_id = ?', [session[:usr_id]]]
  end

  # Before I save a new creation, fill-in some data
  def before_create_save(record)
    do_save_logic(record)
    record.usr_id = session[:usr_id]
  end # before_create_save

  # Before I save a new update, fill-in some data
  def before_update_save(record)
    do_save_logic(record)
    if (record.usr_id != session[:usr_id])
      # Force the call of record.errors.add_to_base "You can only update your records ..."
      # Via record.validate
      # which is defined here: app/models/frgmnt.rb
      record.name = "record_usr_id_ne_session_usr_id"
    end #if
  end # before_update_save

  # Before any kind of save, do this.
  # The logic here can be visualized as a 2D grid.
  # On x-Axis we have types of input used to build the fragment: Parent Fragement, Input URL.
  # On y-Axis we have types of Hpricot expressions used to scrape the input:
  #     .search(), .at(), display-enumerable(), etc
  # This logic is implemented via a large case-statement.
  # Each branch is triggered by a pair of variables:
  #  - type of input (Input URL, Parent Fragement.)
  #  - type of  Hpricot expression (.search(), .at(), display-enumerable(), etc )
  # When I wrote Edgar411.com I used nested case-statements.
  # That is more DRY but harder to maintain.
  # So here, I use just one case-statement which branches on and-ed variable-pairs.
  # Also seeing the variables paired up makes it easier for me to visualize this as a 2D grid.
  # The names of the 2 variables are:
  #  - record.inputurl
  #  - record.exprtype.name
  def do_save_logic(record)
    # shorten the variable names
    urlin = record.inputurl
    expname = record.exprtype.name
    ptxt = record.parent.frgtxt unless record.parent.nil?
    a1 = record.arg1
    a2 = record.arg2
    a3 = record.arg3
    a4 = record.arg4
    case
    when record.valid? == false
      record.frgtxt = "<b>The Data In This Fragment Is Invalid.</b>"
    when ((urlin != nil) and (expname == ".search()"))
      hpricot_object = get_my_hp_elem(urlin)
      record.frgtxt = hpricot_object.search(a1).to_html
    when ((urlin == nil) and (expname == ".search()"))
      hpricot_object = Hpricot(ptxt)
      record.frgtxt = hpricot_object.search(a1).to_html
    when ((urlin != nil) and (expname == ".search().first"))
      hpricot_object = get_my_hp_elem(urlin)
      record.frgtxt = hpricot_object.search(a1).first.to_html
    when ((urlin == nil) and (expname == ".search().first"))
      hpricot_object = Hpricot(ptxt)
      record.frgtxt = hpricot_object.search(a1).first.to_html
    when ((urlin != nil) and (expname == ".search().last"))
      hpricot_object = get_my_hp_elem(urlin)
      record.frgtxt = hpricot_object.search(a1).last.to_html
    when ((urlin == nil) and (expname == ".search().last"))
      hpricot_object = Hpricot(ptxt)
      record.frgtxt = hpricot_object.search(a1).last.to_html
    when ((urlin != nil) and (expname == ".search().prepend()"))
      hpricot_object = get_my_hp_elem(urlin)
      hpricot_object.search(a1).prepend(a2)
      record.frgtxt = hpricot_object.to_html
    when ((urlin == nil) and (expname == ".search().prepend()"))
      hpricot_object = Hpricot(ptxt)
      hpricot_object.search(a1).prepend(a2)
      record.frgtxt = hpricot_object.to_html
    when ((urlin != nil) and (expname == ".search().append()"))
      hpricot_object = get_my_hp_elem(urlin)
      hpricot_object.search(a1).append(a2)
      record.frgtxt = hpricot_object.to_html
    when ((urlin == nil) and (expname == ".search().append()"))
      hpricot_object = Hpricot(ptxt)
      hpricot_object.search(a1).append(a2)
      record.frgtxt = hpricot_object.to_html
    when ((urlin != nil) and (expname == ".search().wrap()"))
      hpricot_object = get_my_hp_elem(urlin)
      hpricot_object.search(a1).wrap(a2)
      record.frgtxt = hpricot_object.to_html
    when ((urlin == nil) and (expname == ".search().wrap()"))
      hpricot_object = Hpricot(ptxt)
      hpricot_object.search(a1).wrap(a2)
      record.frgtxt = hpricot_object.to_html
    when ((urlin != nil) and (expname == ".search().remove"))
      hpricot_object = get_my_hp_elem(urlin)
      hpricot_object.search(a1).remove
      record.frgtxt = hpricot_object.to_html
    when ((urlin == nil) and (expname == ".search().remove"))
      hpricot_object = Hpricot(ptxt)
      hpricot_object.search(a1).remove
      record.frgtxt = hpricot_object.to_html
    when ((urlin != nil) and (expname == ".at()"))
      hpricot_object = get_my_hp_elem(urlin)
      record.frgtxt = hpricot_object.at(a1).to_html
    when ((urlin == nil) and (expname == ".at()"))
      hpricot_object = Hpricot(ptxt)
      record.frgtxt = hpricot_object.at(a1).to_html
    when ((urlin != nil) and (expname == ".at().inner_html"))
      hpricot_object = get_my_hp_elem(urlin)
      record.frgtxt = hpricot_object.at(a1).inner_html
    when ((urlin == nil) and (expname == ".at().inner_html"))
      hpricot_object = Hpricot(ptxt)
      record.frgtxt = hpricot_object.at(a1).inner_html
    when ((urlin != nil) and (expname == ".at().swap()"))
      hpricot_object = get_my_hp_elem(urlin)
      hpricot_object.at(a1).swap(a2)
      record.frgtxt = hpricot_object.to_html
    when ((urlin == nil) and (expname == ".at().swap()"))
      hpricot_object = Hpricot(ptxt)
      hpricot_object.at(a1).swap(a2)
      record.frgtxt = hpricot_object.to_html
    when ((urlin != nil) and (expname == "display-enumerable()"))
      my_html = get_my_html_from_open_uri(urlin)
      record.frgtxt = get_my_hp_enum(my_html,a1)
    when ((urlin == nil) and (expname == "display-enumerable()"))
      my_html = ptxt
      record.frgtxt = get_my_hp_enum(my_html,a1)
    when ((urlin != nil) and (expname == "remove-comments"))
      hpricot_object = get_my_hp_elem(urlin)
      hpricot_object.search("*").each {|e| Hpricot.orphan_node(e) if e.comment?}
      record.frgtxt = hpricot_object.to_html
    when ((urlin == nil) and (expname == "remove-comments"))
      hpricot_object = Hpricot(ptxt)
      hpricot_object.search("*").each {|e| Hpricot.orphan_node(e) if e.comment?}
      record.frgtxt = hpricot_object.to_html
    when ((urlin != nil) and (expname == "display-comments"))
      hpricot_object = get_my_hp_elem(urlin)
      record.frgtxt = hpricot_object.search("*").map {|e| "<hr />#{e}" if e.comment?}.to_s
    when ((urlin == nil) and (expname == "display-comments"))
      hpricot_object = Hpricot(ptxt)
      record.frgtxt = hpricot_object.search("*").map {|e| "<hr />#{e}" if e.comment?}.to_s
    when ((urlin != nil) and (expname == "gsub(/old/,'new')-textnodes"))
      hpricot_object = get_my_hp_elem(urlin)
      old = Regexp.new(a1)
      new = a2
      hpricot_object.search("*").each {|e| (e.content = e.content.gsub(old, new)) if e.text? }
      record.frgtxt = hpricot_object.to_html
    when ((urlin == nil) and (expname == "gsub(/old/,'new')-textnodes"))
      hpricot_object = Hpricot(ptxt)
      old = Regexp.new(a1)
      new = a2
      hpricot_object.search("*").each {|e| (e.content = e.content.gsub(old, new)) if e.text? }
      record.frgtxt = hpricot_object.to_html
    when ((urlin != nil) and (expname == ".search().remove_attr()"))
      hpricot_object = get_my_hp_elem(urlin)
      hpricot_object.search(a1).remove_attr(a2)
      record.frgtxt = hpricot_object.to_html
    when ((urlin == nil) and (expname == ".search().remove_attr()"))
      hpricot_object = Hpricot(ptxt)
      hpricot_object.search(a1).remove_attr(a2)
      record.frgtxt = hpricot_object.to_html
    else
      record.frgtxt = "<b>nil</b>"
    end # case
  end #do_save_logic

  # I got this from a google query about a year ago.
  # I use .search().remove to remove any element which .search() can find.
  # I cannot use .search() for find comments so I use .orphan_node() to help me remove them.
  def Hpricot.orphan_node(node)
   list = node.parent.children
   node.parent = nil
   list.delete(node)
  end

  # Returns Hpricot-enumerable from inputs: (HTML, Hpricot-Scrape-Expression)
  def get_my_hp_enum(h,scrapeexpr)
    # Match something like this:  "body div.gb2>a[@href*='google.com'],[3,8]"
    rgxp = /(.*)?(\,)(\[)(\d+)(,)(\d+)(\])$/
    # Parse scrapeexpr into 3 pieces.
    # 1. Hpricot expression
    # 2. Enumerable starting index
    # 3. Enumerable size
    ma = rgxp.match(scrapeexpr).to_a
    hp_expr = ma[1]
    e0 = ma[4].to_i # starting index
    esize = ma[6].to_i # size of the Enumerable object

    # Debug Hpricot here.
    en_expr = "[#{ma[4]},#{ma[6]}]"
    hp_str = "Hpricot(h).search(hp_expr)#{en_expr}"
    # eval() not available in production
    # hp_enum = eval(hp_str)
    # Debug Hpricot here.

    # Now do it the hard way since I cant use eval()
    hp_enum2 = []
    Hpricot(h).search(hp_expr).each do |e|
      # I count 2 indices as I fill hp_enum2
      # e0 tells me when to start filling hp_enum2
      # esize tells me when to stop filling hp_enum2
      e0 = e0 - 1
      esize = (esize - 1) if (e0 < 0)
      hp_enum2 << e if ((e0 < 0) and (esize > -1))
    end

    # Now I have the data I want.
    # I pretty it up by adding <hr /> and numbering each element in the enumerable object.
    frgtxt = ""
    d = -1
    hp_enum2.each {|e| (d = d + 1); frgtxt << "<hr />#{d.to_s}<p />#{e.to_s}" }
    return frgtxt
  end # get_my_hp_enum()

end # class

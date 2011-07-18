class Ashp::FrgmntsController < ApplicationController

  active_scaffold do |config|
    config.label = "Fragments Built From an EDGAR Report"
    config.list.columns = [:usr, :name, :outputrpt, :parent, :rpt, :inputurl, :scrapeexpr, :exprtype, :frgtxt]
    config.show.columns = [:usr, :name, :outputrpt, :parent, :rpt, :inputurl, :scrapeexpr, :exprtype, :frgtxt]
    config.create.columns = [:name, :outputrpt, :parent, :rpt, :inputurl, :exprtype, :scrapeexpr]
    config.update.columns = [:name, :outputrpt, :parent, :rpt, :inputurl, :exprtype, :scrapeexpr]

    config.columns[:usr].label = "Fragment Owner"
    config.columns[:name].label = "Fragment Name"
    config.columns[:outputrpt].label = "Output Report Built From Fragments"
    config.columns[:parent].label = "Parent Fragment"
    config.columns[:inputurl].label = "Input URL (could be any arbitrary URL)"
    config.columns[:rpt].label = "EDGAR Report Full of Fragments"
    config.columns[:frgtxt].label = "Fragment Text Scraped From Input Source (Report, Parent, or URL)"
    config.columns[:scrapeexpr].label = "Expression Used To Build This Fragment"
    config.columns[:exprtype].label = "Type Of Expression (hpricot, string, gsub, ...)"

    columns[:outputrpt].form_ui = :select
    columns[:rpt].form_ui = :select
    columns[:parent].form_ui = :select
    columns[:exprtype].form_ui = :select

  end

  def rndr_frgmnt
    @myhpelem = Frgmnt.find(params[:id]).frgtxt
    render(:layout => "layouts/html_tag_only")
  end

  # Before I save a new creation, fill-in some data
  def before_create_save(record)
    do_save_logic(record)
    record.usr_id = session[:usr_id]
  end

  # Before I save a new update, fill-in some data
  def before_update_save(record)
    do_save_logic(record)
    if (record.usr_id != session[:usr_id])
      # Force the call of a validation method.
      record.name = "record_usr_id_ne_session_usr_id"
    end
  end

  # Before any kind of save, do this.
  # The logic here can be visualized as a 2D grid.
  # On x-Axis we have types of input used to build the fragment: Parent Fragement, Input Report, Input URL.
  # On y-Axis we have types of scrape expressions used to scrape the input:
  #     hpricot, hpricot-enumerable, string, gsub, sub, and regexp.
  # This logic is implemented via nested case statements.
  # The outer-case handles type of input: parent, rpt, inputurl
  # The inner-case handles type of scrape expression.
  def do_save_logic(record)
    # After validation,
    # I either scrape a record.parent.frgtxt or a record.rpt.uurl or record.inputurl
    case
    when record.valid? == false
      record.frgtxt = "<b>The Data In This Fragment Is Invalid.</b>"

    # 1st branch (the most common) is for when user specifies parent.frgtxt as input
    when record.parent != nil
      # parent is shorthand for record.parent.frgtxt
      # parent is easy for end-user to remember
      parent = record.parent.frgtxt

      # Now that I have the input, branch on the expression type
      case record.exprtype.name

      # peel-off-outer-tag returns parent with outer tag peeled off
      when "peel-off-outer-tag"
        record.frgtxt = peel_off_outer_tag(record)

      # glue-fragment-to-parent allows user to glue any fragment to end of parent fragment
      when "glue-fragment-to-parent"
        record.frgtxt = glue_fragment_to_parent(record)

      # string-sandwich allows user to sandwich parent between 2 strings
      when "string-sandwich"
        record.frgtxt = string_sandwich(record)

      # sub allows user to do this: parent.sub(/change this/,'to this')
      when "sub"
        record.frgtxt = mysub(record)

      # gsub allows user to do this: parent.gsub(/change this/,'to this')
      when "gsub"
        record.frgtxt = mygsub(record)

      # This allows: parent =~ /regexp/
      # Then returns data from matching-array
      when "regexp-enumerable"
        record.frgtxt = regexp_enumerable(record)

      # This branch works well on simple Hpricot scrape expressions like:
      # body or div#some-id or
      # table or a[@href*='yahoo.com'] or
      # span.some-class[text()*='Text I want to match']
      when "hpricot"
        record.frgtxt = Hpricot(record.parent.frgtxt).search(record.scrapeexpr).to_html

      # This branch might be the most useful.
      # It displays a set of enumerable objects.
      # Each is wrapped in a numbered-div-tag.
      # I want the user to enter a scrapeexpr like this:
      # table,[4,3] or
      # body div>table a,[0..999]
      when "hpricot-enumerable"
        record.frgtxt = get_my_hp_enum(record.parent.frgtxt, record.scrapeexpr)
      end # case record.exprtype.name


    # Branch here when user specifies EDGAR report as input
    when record.rpt != nil

      # Now that I have the input, branch on the expression type
      case record.exprtype.name
      when "hpricot"
        record.frgtxt = get_my_hp_elem(record.rpt.uurl).search(record.scrapeexpr).to_html
      when "hpricot-enumerable"
        record.frgtxt = get_my_hp_enum(get_my_html_from_open_uri(record.rpt.uurl), record.scrapeexpr)
      end # record.exprtype.name

    # Branch here when user specifies arbitrary URL as input
    # This is probably rare but is useful for testing purposes.
    when record.inputurl != nil

      # Now that I have the input, branch on the expression type
      case record.exprtype.name
      when "hpricot"
        record.frgtxt = get_my_hp_elem(record.inputurl).search(record.scrapeexpr).to_html
      when "hpricot-enumerable"
        record.frgtxt = get_my_hp_enum(get_my_html_from_open_uri(record.inputurl), record.scrapeexpr)
      end # record.exprtype.name

    end # The outer-case handles type of input: parent, rpt, inputurl

  end   # do_save_logic()



  # Returns raw HTML.  Usually it gets passed to get_my_hp_elem()
  def get_my_html_from_open_uri(u)
    hdrs = {"User-Agent"=>"Mozilla/5.0 (Macintosh; U; PPC Mac OS X Mach-O; en-US; rv:1.8.1.1) Gecko/20061204 Firefox/2.0.0.1", "Accept-Charset"=>"utf-8", "Connection"=>"Keep-Alive", "Accept"=>"text/html"}
    my_html = ""
    begin
      open(u, hdrs).each {|s| my_html << s}
    rescue
      my_html = "<html><body><p /><b>hello world</b></body></html>"
    end
    return my_html
  end # get_my_html_from_open_uri()

  # Returns an Hpricot object from HTML obtained by get_my_html_from_open_uri()
  def get_my_hp_elem(u)
    h0 = Hpricot(get_my_html_from_open_uri(u))
    # remove crap
    # (h0/"script").remove
    return h0
  end #get_my_hp_elem()

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
    # I pretty it up by wrapping it in a div-tag-border and numbering each element in the enumerable object.
    frgtxt = ""
    d = -1
    hp_enum2.each {|e| (d = d + 1); frgtxt << "<div class='hp-enum-divwrap'>#{d.to_s}<p />#{e.to_s}</div>" }
    return frgtxt
  end # get_my_hp_enum()

  # Allows me to sandwich parent between 2 strings.
  # parent is passed in via an AR object named record by AS.
  def string_sandwich(record)

    # Assume the parent's fragment text was passed in.
    parent = (record.parent.frgtxt || "")

    # copy the scrape expression into a simple variable so I can study it.
    s = record.scrapeexpr
    # Use a regexp to parse s
    # Try to match something like this:
    # s = '"hello"+parent'
    # or this:
    # s = '"hello"+parent+"bye"'
    rg2 = /^(".*?")(\+)(parent)$/
    rg3 = /^(".*?")(\+)(parent)(\+)(".*")$/
    # use .match() to parse tokens into array
    m2 = rg2.match(s).to_a
    m3 = rg3.match(s).to_a
    case
    when (m2.size == 0 and m3.size == 0)
      return 'Improperly formatted string sandwich.  I need something like this: "<hr />"+parent+"<hr />"'
    when (m2.size == 4)
      return m2[1].sub(/^\"/,'').sub(/\"$/,'') + parent
    when (m3.size == 6)
      return m3[1].sub(/^\"/,'').sub(/\"$/,'') + parent +  m3[5].sub(/^\"/,'').sub(/\"$/,'')
    else
      return 'Improperly formatted string sandwich.  I need something like this: "<hr />"+parent+"<hr />"'
    end # case
  end # string_sandwich

  # Wraps .sub()
  def mysub(record)
    # Assume the parent's fragment text was passed in.
    parent = (record.parent.frgtxt || "")
    # copy the scrape expression into a simple variable so I can study it.
    s = record.scrapeexpr
    # Use a regexp to parse s
    # Try to match something like this:
    # s = 'sub(/^matchme$/,"then gimme this")'
    rg =  /^sub\(\/(.*?)\/,"(.*?)"\)$/
    m = rg.match(s).to_a
    # I should now have 2 tokens: regexp-token, replacement-text-token
    return "sub format error.  Try again." if (m.size != 3)
    # Build the sub-regexp
    srg = Regexp.new(m[1])
    # Note the replacement text
    rt = m[2]
    # run .sub() against the parent's fragment text
    newtext = parent.sub(srg, rt)
    # send it back
    return newtext
  end

  # Wraps .gsub()
  def mygsub(record)
    # Assume the parent's fragment text was passed in.
    parent = (record.parent.frgtxt || "")
    # copy the scrape expression into a simple variable so I can study it.
    s = record.scrapeexpr
    # Use a regexp to parse s
    # Try to match something like this:
    # s = 'gsub(/^matchme$/,"then gimme this")'
    rg =  /^gsub\(\/(.*?)\/,"(.*?)"\)$/
    m = rg.match(s).to_a
    # I should now have 2 tokens: regexp-token, replacement-text-token
    return "gsub format error.  Try again." if (m.size != 3)
    # Build the gsub-regexp
    srg = Regexp.new(m[1])
    # Note the replacement text
    rt = m[2]
    # run .gsub() against the parent's fragment text
    newtext = parent.gsub(srg, rt)
    # send it back
    return newtext
  end

  # Wraps regexp and returns a div-wrapped match array
  def regexp_enumerable(record)
    # Assume the parent's fragment text was passed in.
    parent = (record.parent.frgtxt || "")
    # copy the scrape expression into a simple variable so I can study it.
    s = record.scrapeexpr
    # Use a regexp to parse s
    # Try to match something like this:
    # s = '/^matchme$/'
    rg1 = /^\/(.*?)\/$/
    m = rg1.match(s).to_a
    # I need to untangle the parsing-regexp from the user's regexp
    if m.size == 2
      usr_regexp_s = m[1]
    else
      return 'Format problem with your regexp.  Try something like this:  /^(abc)(123)$/'
    end

    # Now work with the user's regexp and parent fragment
    usr_regexp = Regexp.new(m[1])
    usr_match = usr_regexp.match(parent).to_a
    return "Your Regular Expression Matches Nothing In The Parent Fragment" if (usr_match.size == 0)
    # I should now have a match but it's in an array.
    # Give it back to the user in a form he can use.
    # I guess a simple set of div-tags is friendly.
    usr_match_s = ""
    d = -1
    usr_match.each do |e|
      d = d + 1
      usr_match_s << "<div class='regexp-enum-divwrap'>#{d.to_s}<p />#{e}</div>"
    end #  usr_match.each
    return usr_match_s
  end # regexp_enumerable(record)

  # Allows user to specify a fragment name and then glue the fragment
  # text to the end of the currently selected parent's text.
  def glue_fragment_to_parent(record)
    # Assume the user passed in the fragment name via the scrape expression.
    frgname = record.scrapeexpr
    # Get the text I want to apply glue to.
    myfrg = Frgmnt.find_by_name(frgname)
    if myfrg
      myfrgtxt = Frgmnt.find_by_name(frgname).frgtxt
    else
      myfrgtxt = " <hr /><h1>Invalid glue fragment name.  Try a different name. </h1>"
    end # if myfrg
    # glue-em and return-em
    return record.parent.frgtxt + myfrgtxt
  end # glue_fragment_to_parent(record)

  # Returns parent with the outer-tag peeled off
  def peel_off_outer_tag(record)
    rg = /(<\w+\s+.*?>)(.*)(<\/\w+>)/
    m_a = rg.match(record.parent.frgtxt).to_a
    # I want the meat in the middle of the sandwich.
    return m_a[2]
  end # peel_off_outer_tag

end # class

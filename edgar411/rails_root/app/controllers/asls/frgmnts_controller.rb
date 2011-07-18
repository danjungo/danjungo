# Provides read-only view via active_scaffold
class Asls::FrgmntsController < ApplicationController

  skip_before_filter :authenticate_usr

  active_scaffold do |config|
    config.actions = [:list, :show, :search]
    config.label = "Fragments Built From an EDGAR Report"
    config.list.columns = [:usr, :name, :outputrpt, :parent, :rpt, :inputurl, :scrapeexpr, :exprtype, :frgtxt]
    config.show.columns = [:usr, :name, :outputrpt, :parent, :rpt, :inputurl, :scrapeexpr, :exprtype, :frgtxt]

    config.columns[:usr].label = "Fragment Owner"
    config.columns[:name].label = "Fragment Name"
    config.columns[:outputrpt].label = "Output Report Built From Fragments"
    config.columns[:rpt].label = "EDGAR Report Full of Fragments"
    config.columns[:frgtxt].label = "Fragment Text Scraped From Input Source (Report, Parent, or URL)"
    config.columns[:scrapeexpr].label = "Expression Used To Build This Fragment"
    config.columns[:exprtype].label = "Type Of Expression (hpricot, string, gsub, ...)"

  end # active_scaffold

  def rndr_frgmnt
    @myhpelem = Frgmnt.find(params[:id]).frgtxt
    render(:layout => "layouts/html_tag_only")
  end # rndr_frgmnt
end # class

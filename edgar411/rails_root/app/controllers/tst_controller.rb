class TstController < ApplicationController

  def index
    render(:layout => "layouts/html_tag_only")
  end
  def tst4
    @d11 = "<b>hello</b><p />" + params["tst3"]["tst3data"]
  end
end

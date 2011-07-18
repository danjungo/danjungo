class SttcController < ApplicationController

  def about
    Usr.find_by_sql "DELETE FROM sessions WHERE updated_at < (SELECT MAX(updated_at - INTERVAL '1 hour')  FROM sessions)"    
    @sessn_cnt= (Usr.find_by_sql "SELECT COUNT(*) AS cnt FROM sessions").first.cnt
  end

  def sessn_cnt
    @sessn_cnt= (Usr.find_by_sql "SELECT COUNT(*) AS cnt FROM sessions").first.cnt
  end


end

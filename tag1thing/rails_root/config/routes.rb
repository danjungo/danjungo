ActionController::Routing::Routes.draw do |map|
  map.root :controller => "thngs", :action => "publicize"
  map.resources :srchs
  map.connect '/ssearch/:action', :controller => "ssearch"
#  map.connect '/ssearch/form4tag', :controller => "ssearch", :action => "form4tag"
  map.connect '/Guest', :controller => "usrs", :action => "profile"

  map.connect 'thngs/createm', :controller => "thngs", :action => "createm"
  map.connect 'thngs/createm4memorize', :controller => "thngs", :action => "createm4memorize"
  map.connect 'thngs/createm4publicize', :controller => "thngs", :action => "createm4publicize"
  map.connect 'thngs/editem', :controller => "thngs", :action => "editem"
  map.connect 'thngs/just_thngdsc', :controller => "thngs", :action => "just_thngdsc"
  map.connect 'thngs/memorize', :controller => "thngs", :action => "memorize"
  map.connect 'thngs/newfast', :controller => "thngs", :action => "newfast"
  map.connect 'thngs/publicize', :controller => "thngs", :action => "publicize"
  map.connect 'thngs/show2col', :controller => "thngs", :action => "show2col"
  map.connect 'thngs/shrturl_show', :controller => "thngs", :action => "shrturl_show"
  map.connect 'thngs/update', :controller => "thngs", :action => "update"
  map.connect 'thngs/updatem', :controller => "thngs", :action => "updatem"
  map.resources :thngs
  map.register 'register', :controller => "usrs", :action => "register"
  map.why 'why', :controller => "usrs", :action => "why"
  map.usr_thngs 'usr_thngs', :controller => "usrs", :action => "usr_thngs"
  map.resources :usrs
  map.connect 'usrs/:action', :controller => "usrs" # I need this route. See #register(), #why()
  map.login  'login', :controller => 'consumer', :action => 'login'
  map.logout 'logout',:controller => 'sessions', :action => 'logout'
  map.about 'about',  :controller => 'welcome', :action => 'index'
  map.connect '/consumer/:action', :controller => "consumer"
  map.connect '/ssud/:action', :controller => "ssud"
  map.connect '/welcome/:action', :controller => "welcome"
  map.connect '/danbook/:action', :controller => "danbook"
  map.connect '/tags/tag_thngs', :controller => "tags", :action => "tag_thngs"
  map.resources :tags
  map.connect '/*shrturl', :controller => 'thngs', :action => 'shrturl_show', :conditions => { :method => :get }

  map.connect ':controller/:action/:id'
  map.connect ':controller/:action/:id.:format'
end

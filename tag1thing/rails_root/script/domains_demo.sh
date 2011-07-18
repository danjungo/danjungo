# script/domains_demo.sh

heroku addons:info
heroku addons:add custom_domains:basic
heroku domains:add tag1thing.com
heroku domains:add tag611.com
heroku domains:add t1t.us
heroku domains:add www.tag1thing.com
heroku domains:add www.tag611.com
heroku domains:add www.t1t.us

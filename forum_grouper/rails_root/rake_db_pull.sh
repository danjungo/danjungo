#
# rake_db_pull.sh
#


# db_type = postgres  role = maco  db_name = fg13_development
heroku db:pull postgres://maco@localhost/fg13_development

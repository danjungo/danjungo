#
# /pt/t1t/db/db_push_t1t.sh
#


# db_type = postgres  role = maco  db_name = t1t
heroku db:reset --app t1t
heroku db:push postgres://maco@localhost/t1t
echo remem this: dbviews/ccreateviews

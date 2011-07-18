# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_t12_session',
  :secret      => 'e25402b704b5774665f334bc38cc772fd2931afd28d3f9768b61c712bcff3ad3ed7716bd56c4302c78c4d16296dea250ac5947640f3386a1c1f01912c68ef85f'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_c11_session',
  :secret      => '96bb521964f56a562de9e7bda7adafc7e1a1f6074f61e873928d4c65dfbef7020a3ecd3a151555ba74316ef8f2228eb2c58f98548cf759f76840bc77c5764a93'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_jnk_session',
  :secret      => '1d3e0b1177a12c373377c9712f76d08bfc9e551645798cd29090e711a1f971e6705066a238e7bdaca695d2b9c92b39041d6241d1dd8ffea52e283b5bd4af4390'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

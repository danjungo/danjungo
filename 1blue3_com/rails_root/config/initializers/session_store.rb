# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_em11_session',
  :secret      => 'd4dc0a21774d0774e3a797fcce2fcb3c7e3e8d2280b4d656d5a3885908e124942f0fbd290bc61889a8ab15ef8eae7e6297aef301ca0e780eef361cabeffade62'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

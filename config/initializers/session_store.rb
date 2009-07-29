# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_nyc_stations_session',
  :secret      => 'dc8eb1e4c0fff9670229d155376ce7a356aaedeac358da2acfda75cae2e015404786a72c75f6960c860337c2a18b9b3843cc7538a29c9280f18901474aaa9032'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

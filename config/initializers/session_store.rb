# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_wedding_session',
  :secret      => 'c963c6c00bd694b65384aa06f98dcc7984fc9b876f503605abaefa41d7013470b3f4faee7e5ab0e17256d59923ca6b0b175c90f93ae6a31945c83708d1435010'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

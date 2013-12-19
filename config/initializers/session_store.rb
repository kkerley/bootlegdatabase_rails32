# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_bootlegs_session',
  :secret      => '09b89f32d595ae1822d54ac6520d70ad614db0e5868e5f50621992d208deafe685f52e2510c614893311f5e0afcacfab42834dd51cf63dd1020a737064979a8c'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store

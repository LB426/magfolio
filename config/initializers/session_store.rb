# Be sure to restart your server when you modify this file.
# так было по дефолту
# Magfolio::Application.config.session_store :cookie_store, :key => '_magfolio_session'

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rails generate session_migration")
# Magfolio::Application.config.session_store :active_record_store

# это добавил я
Rails.application.config.session_store :active_record_store, :expire_after => 60.minutes
# возможные ключи:
# :key => 'whatever', :secret => 'nottellingyou',

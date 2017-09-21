require 'dotenv'
Dotenv.load(Rails.root.join('config', 'tmdb_api_key.env'))

Tmdb::Api.key(ENV['TMDB_API_KEY'])
Tmdb::Api.language("en")

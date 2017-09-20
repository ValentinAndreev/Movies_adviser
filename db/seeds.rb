# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#

require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'themoviedb-api'
require 'dotenv'
Dotenv.load(Rails.root.join('config', 'tmdb_api_key.env'))

User.create!(username: 'admin', email: 'admin@mail.com', password: 'password', password_confirmation: 'password', is_admin: true) unless User.find_by(username: 'admin')

Movie.destroy_all
Tmdb::Api.key(ENV['TMDB_API_KEY'])
Tmdb::Api.language("en")
index = 0
(1..20).each do |page_number|
  url = "http://www.imdb.com/search/title?groups=top_1000&sort=user_rating&view=simple&page=#{page_number}&ref_=adv_nxt"
  html = open(url)
  page = Nokogiri::HTML(html)
  page.css('.lister-item-header').each do |data|
    text = data.to_s
    position = text.index("/title/")
    number = text[position+7..position+15]
    movie_data = Tmdb::Find.movie(number, external_source: 'imdb_id').first
    sleep 0.35
    index += 1
    Movie.create!(genre_ids: movie_data.genre_ids, title: movie_data.title, overview: movie_data.overview, vote_average: movie_data.vote_average, poster_path: movie_data.poster_path, imbd_id: number)
    puts "#{index} - #{movie_data.title}"
  end
end

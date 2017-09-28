require 'rubygems'
require 'open-uri'
require 'nokogiri'
require 'themoviedb-api'

User.create!(username: 'admin',
             email: 'admin@mail.com',
             password: 'password',
             password_confirmation: 'password',
             is_admin: true) unless User.find_by(username: 'admin')

Movie.destroy_all
movies_data = []
(1..20).each do |page_number|
  url = "http://www.imdb.com/search/title?groups=top_1000&sort=user_rating&view=simple&page=#{page_number}&ref_=adv_nxt"
  html = open(url)
  page = Nokogiri::HTML(html)
  page.css('.lister-col-wrapper').each do |data|
    text = data.to_s
    position = text.index("/title/")
    number = text[position+7..position+15]
    position = text.index("votes")
    vote = text[position+36..position+38].to_f
    movie_data = Tmdb::Find.movie(number, external_source: 'imdb_id').first
    movie_genres = Tmdb::Movie.detail(movie_data.id).genres
    genres = []
    movie_genres.each { |genres_id| genres << genres_id.name }
    sleep 0.35
    Movie.create!(genres: genres, 
                  title: movie_data.title,
                  overview: movie_data.overview,
                  poster_path: movie_data.poster_path,
                  imbd_id: number,
                  vote_average: vote,
                  tmdb_id: movie_data.id,
                  release_date: movie_data.release_date.to_date)
    puts Movie.last.title
  end
end
puts "Added #{Movie.count} movies to DB"

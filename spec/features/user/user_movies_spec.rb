require 'rails_helper'

feature "User's actions" do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }
  let!(:another_movie) { create(:movie, title: 'Gladiator', tmdb_id: 98) }  
  before { log_in_user(user.username, user.password) }

  scenario 'user can see list of all movies' do
    click_on 'All movies'
    check_list_of_content(['List of all movies', "#{movie.title} (#{movie.release_date.year})", movie.overview, movie.vote_average])
  end

  scenario 'user can visit page of movie' do
    click_on 'All movies'
    click_on "#{movie.title} (#{movie.release_date.year})"
    check_list_of_content(['Genres', 'Rating', movie.genres.join(', '), movie.overview, movie.vote_average])
    expect(page).to have_link("This movie on IMBD", href: "http://www.imdb.com/title/#{movie.imbd_id}/")
  end

  scenario 'user can visit page of TMDB recommendations for movie' do
    click_on 'All movies'
    click_on "#{movie.title} (#{movie.release_date.year})"
    click_on "Recommendations from TMDB"
    check_list_of_content(["Recommendations from TMDB for #{movie.title}:", "#{another_movie.title}"])
    expect(page).to have_link("Path")
  end
end
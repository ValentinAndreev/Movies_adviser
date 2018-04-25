# frozen_string_literal: true

require 'rails_helper'

feature "User's actions on movies" do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }
  let!(:another_movie) { create(:another_movie) }
  before do
    log_in_user(user.username, user.password)
    click_on 'All movies'
  end

  scenario 'user can see list of all movies' do
    check_presence(["#{movie.title} (#{movie.release_date.year})", movie.overview, movie.vote_average])
  end

  scenario 'user can visit page of movie' do
    click_on "#{movie.title} (#{movie.release_date.year})"
    check_presence(['Genres', 'On', movie.genres.join(' '), movie.overview, movie.vote_average])
    expect(page).to have_link('IMBD', href: "http://www.imdb.com/title/#{movie.imbd_id}/")
  end

  scenario 'user can visit page of TMDB recommendations for movie' do
    click ["#{movie.title} (#{movie.release_date.year})", 'Recommendations from TMDB']
    check_presence(["Recommendations from TMDB for: #{movie.title}", another_movie.title.to_s])
    expect(page).to have_link(href: "/movies/#{another_movie.id}")
  end

  scenario 'user can search movie by name' do
    fill_in 'search', with: 'shawshank'
    click_on 'Search/reorder'
    expect(page).to have_content('The Shawshank Redemption')
    expect(page).to_not have_content('Gladiator')
  end

  scenario 'user can search movie by genre' do
    select('Crime', from: 'genres').select_option
    click_on 'Search/reorder'
    expect(page).to have_content('The Shawshank Redemption')
    expect(page).to_not have_content('Gladiator')
  end

  scenario 'user can order movies by rating' do
    page.find(:css, '[id=rating]').set(true)
    click_on 'Search/reorder'
    expect(page).to have_content('rating')
  end

  scenario 'user can order movies by date' do
    page.find(:css, '[id=date]').set(true)
    click_on 'Search/reorder'
    expect(page).to have_content('date')
  end

  scenario 'user can reverse order of movies' do
    page.find(:css, '[name=order]').set(true)
    click_on 'Search/reorder'
    expect(page).to have_content('reversed')
  end

  scenario 'user can open all movies by genre from single movie' do
    click ["#{movie.title} (#{movie.release_date.year})", 'Drama']
    expect(page).to have_content('The Shawshank Redemption')
    expect(page).to_not have_content('Gladiator')
  end
end

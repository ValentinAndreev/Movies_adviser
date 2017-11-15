require 'rails_helper'

feature "User's actions" do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }
  let!(:another_movie) { create(:movie, title: 'Gladiator', tmdb_id: 98, genres: ["Action"]) }  
  before do
    log_in_user(user.username, user.password)
    click_on 'All movies'    
  end

  scenario 'user can see list of all movies' do
    check_list_of_content(['List of all movies', "#{movie.title} (#{movie.release_date.year})", movie.overview, movie.vote_average])
  end

  scenario 'user can visit page of movie' do
    click_on "#{movie.title} (#{movie.release_date.year})"
    check_list_of_content(['Genres', 'Rating', movie.genres.join(', '), movie.overview, movie.vote_average])
    expect(page).to have_link("This movie on IMBD", href: "http://www.imdb.com/title/#{movie.imbd_id}/")
  end

  scenario 'user can visit page of TMDB recommendations for movie' do
    click_on "#{movie.title} (#{movie.release_date.year})"
    click_on "Recommendations from TMDB"
    check_list_of_content(["Recommendations from TMDB for #{movie.title}:", "#{another_movie.title}"])
    expect(page).to have_link("Path")
  end

  scenario 'user can set own recommendations on movie' do
    Capybara.exact = true
    click_on "#{movie.title} (#{movie.release_date.year})"
    expect(page).to have_content("Your recommendation: neutral")
    expect(page).to have_link("recommended")
    expect(page).to have_link("not recommended")
    click_on 'recommended'
    expect(page).to_not have_link("Your recommendation: recommended")
    click_on 'not recommended'
    expect(page).to_not have_link("Your recommendation: not recommended")
  end

  scenario 'user can search movie by name' do
    fill_in 'search', with: 'shawshank'
    click_on 'Search'
    expect(page).to have_content("The Shawshank Redemption")
    expect(page).to_not have_content("Gladiator")
  end

  scenario 'user can search movie by genre' do
    select("Crime", from: "genres").select_option
    click_on 'Search'
    expect(page).to have_content("The Shawshank Redemption")
    expect(page).to_not have_content("Gladiator")
  end
end
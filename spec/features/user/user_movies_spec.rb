require 'rails_helper'

feature "User's actions" do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }
  let!(:another_movie) { create(:movie, title: 'Gladiator', tmdb_id: 98, release_date: "1993-09-23", vote_average: 8.5, genres: ["History"]) }
  before do
    log_in_user(user.username, user.password)
    click_on 'All movies'    
  end

  scenario 'user can see list of all movies' do
    check_list_of_content(["#{movie.title} (#{movie.release_date.year})", movie.overview, movie.vote_average])
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

  scenario 'user can search movie by name' do
    fill_in 'search', with: 'shawshank'
    click_on 'Search/reorder'
    expect(page).to have_content("The Shawshank Redemption")
    expect(page).to_not have_content("Gladiator")
  end

  scenario 'user can search movie by genre' do
    select("Crime", from: "genres").select_option
    click_on 'Search/reorder'
    expect(page).to have_content("The Shawshank Redemption")
    expect(page).to_not have_content("Gladiator")
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
end
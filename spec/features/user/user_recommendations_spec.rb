require 'rails_helper'

feature "User's recommendations" do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }
  let!(:another_movie) { create(:movie, title: 'Gladiator', tmdb_id: 98, release_date: "1993-09-23", vote_average: 8.5) }
  before do
    log_in_user(user.username, user.password)
    click_on 'All movies'
  end

  scenario 'user can set and see list of own recommendations' do
    click_on "#{movie.title} (#{movie.release_date.year})"
    expect(page).to have_content("Your recommendation: neutral")
    expect(page).to have_link("recommended")
    expect(page).to have_link("not recommended")
    click_on 'recommended'
    expect(page).to_not have_link("Your recommendation: recommended")
    click_on 'All movies'
    select("Recommended", from: "recommendation").select_option
    click_on 'Search/reorder'
    expect(page).to have_content("#{movie.title} (#{movie.release_date.year})")
    expect(page).to_not have_content("#{another_movie.title} (#{another_movie.release_date.year})")
  end

  scenario 'user can set and see list of not recommended movies' do
    click_on "#{another_movie.title} (#{another_movie.release_date.year})"
    expect(page).to have_content("Your recommendation: neutral")
    expect(page).to have_link("recommended")
    expect(page).to have_link("not recommended")
    click_on 'not recommended'
    expect(page).to_not have_link("Your recommendation: not recommended")
    click_on 'All movies'    
    select("Not recommended", from: "recommendation").select_option
    click_on 'Search/reorder'
    expect(page).to have_content("#{another_movie.title} (#{another_movie.release_date.year})")
    expect(page).to_not have_content("#{movie.title} (#{movie.release_date.year})")
  end
end
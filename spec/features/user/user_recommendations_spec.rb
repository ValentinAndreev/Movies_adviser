require 'rails_helper'

feature "User's recommendations" do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }
  let!(:another_movie) { create(:movie, title: 'Gladiator', tmdb_id: 98) }  
  before do
    log_in_user(user.username, user.password)
    click_on 'All movies'    
  end

  scenario 'user can edit and see list of own recommendations' do
    Capybara.exact = true
    click_on "#{movie.title} (#{movie.release_date.year})"
    click_on 'recommended'
    click_on 'Recommended'
    check_list_of_content(["List of recommended movies", "#{movie.title} (#{movie.release_date.year})"])    
    expect(page).to_not have_content("#{another_movie.title} (#{another_movie.release_date.year})")
  end

  scenario 'user can edit and see list of not recommended movies' do
    Capybara.exact = true
    click_on "#{another_movie.title} (#{another_movie.release_date.year})"
    click_on 'not recommended'
    click_on 'Not recommended'
    check_list_of_content(["List of not recommended movies", "#{another_movie.title} (#{another_movie.release_date.year})"])    
    expect(page).to_not have_content("#{movie.title} (#{movie.release_date.year})")
  end
end
require 'rails_helper'

feature 'Comment actions' do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }

  scenario 'user can create comment' do
    log_in_user(user.username, user.password)
    click_on 'All movies'
    click_on "#{movie.title} (#{movie.release_date.year})"
    click_on 'New comment'
    fill_in 'comment[body]', with: 'Comment text'
    click_on 'Submit'
    expect(page).to have_selector('#form-comment', visible: false)
    expect(page).to have_content 'Comment text'
  end
end
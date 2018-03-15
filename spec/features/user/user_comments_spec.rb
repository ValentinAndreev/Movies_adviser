# frozen_string_literal: true

require 'rails_helper'

feature 'Comment actions' do
  let!(:user) { create(:user) }
  let!(:movie) { create(:movie) }
  let!(:review) { create(:review, user_id: user.id, movie_id: movie.id) }

  before { log_in_user(user.username, user.password) }

  scenario 'user can create comment for movie' do
    click ['All movies', "#{movie.title} (#{movie.release_date.year})", 'New comment']
    fill_in 'comment[body]', with: 'Comment text'
    click_on 'Submit'
    expect(page).to have_selector('#form-comment', visible: false)
    expect(page).to have_content 'Comment text'
  end

  scenario 'user can create comment for review' do
    click ['All movies', "#{movie.title} (#{movie.release_date.year})", 'My review', 'New comment']
    fill_in 'comment[body]', with: 'Comment text'
    click_on 'Submit'
    expect(page).to have_selector('#form-comment', visible: false)
    expect(page).to have_content 'Comment text'
  end
end

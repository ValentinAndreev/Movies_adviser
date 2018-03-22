# frozen_string_literal: true

require 'rails_helper'

feature "User's actions on reviews" do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user, username: 'another_name', email: 'another@mail.com') }
  let!(:movie) { create(:movie) }
  let!(:review) { create(:review, user_id: user.id, movie_id: movie.id, text: 'Text of review') }
  let!(:another_review) { create(:review, user_id: another_user.id, movie_id: movie.id, text: 'Another review') }
  before do
    log_in_user(user.username, user.password)
    click ['All movies', "#{movie.title} (#{movie.release_date.year})"]
  end

  scenario 'user can open own review' do
    click_on 'My review'
    expect(page).to have_content('Text of review')
  end

  scenario 'user can edit own review' do
    click ['My review', 'Edit review']
    find("#trix_input_review_#{review.id}", visible: false).set('<div>Edited review</div>')
    click_on 'Submit'
    expect(page).to_not have_content('Text of review')
    expect(page).to have_content('Edited review')
  end

  scenario 'user can delete and create own review' do
    click ['My review', 'Destroy']
    expect(page).to_not have_content('Edited review')
    click ["#{movie.title} (#{movie.release_date.year})", 'Create review']
    find('#trix_input_review', visible: false).set('<div>Text of review</div>')
    click_on 'Submit'
    check_presence(["Review of #{review.user.username}", 'Text of review'])
  end

  scenario 'user can see all reviews' do
    click_on 'All reviews'
    check_presence(['Text of review', 'Another review'])
  end

  scenario 'user can only see another users reviews' do
    click ['All reviews', 'Destroy']
    check_absence(['Edit review', 'Destroy'])
    click_on 'Show'
    expect(page).to have_content("Review of #{another_user.username}")
  end
end

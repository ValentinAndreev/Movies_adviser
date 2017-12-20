require 'rails_helper'

feature "User's follow actions" do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user, username: 'another_name', email: 'another@mail.com') }

  before do
    log_in_user(user.username, user.password)
    click_on 'Users'
  end

  scenario 'user can follow to another user' do
    click_on another_user.username
    click_on 'Follow'
    expect(page).to have_content 'followers 1'
    expect(page).to have_button 'Unfollow'
  end

  scenario 'user can unfollow from another user' do
    create(:relationship, follower_id: user.id, followed_id: another_user.id)
    click_on another_user.username
    click_on 'Unfollow'
    expect(page).to_not have_content 'followers 1'
    expect(page).to_not have_link 'Unfollow'    
    expect(page).to have_button 'Follow'
  end

  scenario "user can't follow to himself" do
    click_on 'Users'
    click_on "#{user.id}"
    expect(page).to_not have_button 'Follow'
    expect(page).to_not have_button 'Unfollow'
  end
end
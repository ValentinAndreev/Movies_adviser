# frozen_string_literal: true

require 'rails_helper'

feature "User's actions" do
  let!(:user) { create(:user) }
  let!(:another_user) { create(:user, username: 'another_name', email: 'another@mail.com') }

  before { log_in_user(user.username, user.password) }

  scenario 'view own profile' do
    click_on user.username
    check_presence([user.username, user.email])
  end

  scenario 'view list of users' do
    click_on 'Users'
    check_presence([user.username, another_user.username])
  end

  scenario 'view another user profile' do
    click ['Users', another_user.username]
    expect(page).to have_content user.username
    expect(page).to_not have_content user.email
  end
end

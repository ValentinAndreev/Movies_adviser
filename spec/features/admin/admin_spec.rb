require 'rails_helper'

feature "Admin - dashboard" do
  let!(:user) { create(:user, username: 'admin', is_admin: true) }

  scenario "user can't see admin's dashboard" do
    log_in_user(user.username, user.password)
    expect(page).to have_content 'Admin root'
  end
end
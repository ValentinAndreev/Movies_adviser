require 'rails_helper'

feature "User - dashboard" do
  let!(:user) { create(:user) }

  scenario "user can't see admin's dashboard" do
    log_in_user(user.username, user.password)
    expect(page).to_not have_content 'Admin root'
  end
end
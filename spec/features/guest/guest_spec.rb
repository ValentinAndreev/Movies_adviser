require 'rails_helper'

feature "Guest's actions" do
  background { visit root_path }

  scenario 'guest must see invitation to regitration or login and links to do it' do
    expect(page).to have_content 'Guest'    
    expect(page).to have_content 'You need to sign in or sign up before continuing.'
    expect(page).to have_content 'Sign in'
    expect(page).to have_content 'Sign up'
  end

  scenario "guest can't see links to users actions" do
    expect(page).to_not have_content 'Logout'
    expect(page).to_not have_content 'Edit profile'
    expect(page).to_not have_content 'Home'
  end

  scenario 'guest can sign up' do
    click_on 'Sign up'
    fill_in 'Email', with: 'mail@mail.com'
    fill_in 'Username', with: 'Name'
    fill_in 'Password', with: 'password'
    fill_in 'Password confirmation', with: 'password'
    click_on 'Sign up'
    expect(page).to have_content 'Welcome! You have signed up successfully.'
  end
end
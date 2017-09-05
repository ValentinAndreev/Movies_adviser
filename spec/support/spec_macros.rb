module SpecMacros
  def log_in_user(name, password)
    visit root_path
    fill_in 'Username', with: name
    fill_in 'Password', with: password
    click_on 'Sign in'
  end
end
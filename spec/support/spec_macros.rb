# frozen_string_literal: true

module SpecMacros
  def log_in_user(name, password)
    visit root_path
    fill_in 'Username', with: name
    fill_in 'Password', with: password
    click_on 'Sign in'
  end

  def check_presence(content)
    content.each do |element|
      expect(page).to have_content element
    end
  end

  def check_absence(content)
    content.each do |element|
      expect(page).to_not have_content element
    end
  end

  def check_links(content)
    content.each do |element|
      expect(page).to have_link element
    end
  end

  def click(elements)
    elements.each do |element|
      click_on element
    end
  end
end

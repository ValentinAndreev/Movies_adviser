module SpecMacros
  def log_in_user(name, password)
    visit root_path
    fill_in 'Username', with: name
    fill_in 'Password', with: password
    click_on 'Sign in'
  end

  def check_list_of_content(content, presence = true)
    content.each do |element|
      if presence == true
        expect(page).to have_content element
      else
        expect(page).to_not have_content element
      end
    end
  end

  def check_list_of_links(content, presence = true)
    content.each do |element|
      if presence == true
        expect(page).to have_link element
      else
        expect(page).to_not have_link element
      end
    end
  end  
end
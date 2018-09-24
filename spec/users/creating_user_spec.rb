require 'rails_helper.rb'

feature 'Creating user' do
	scenario 'can create a user' do
		visit '/users/new'
		fill_in 'user_name', with: 'testuser1'
		click_button 'Save User'
		expect(page).to have_content('testuser1')
	end
end
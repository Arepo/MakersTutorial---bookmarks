require 'spec_helper'
require_relative 'helpers/session'

include SessionHelpers

feature "User signs up" do

	scenario "when being logged out" do
		expect(lambda { sign_up }).to change(User, :count).by(1)
		expect(page).to have_content("Welcome, alice@example.com")
		expect(User.first.email).to eq("alice@example.com")
	end

	scenario "with a password that doesn't match" do
		expect(lambda { sign_up('a@a.com', 'pass', 'wrong') }).to change(User, :count).by(0)
		expect(current_path).to eq('/users')
		expect(page).to have_content("Sorry, your passwords don't match")
	end

	scenario "with an email that is already registered" do
		expect{sign_up}.to change(User, :count).by(1)
		expect{sign_up}.to change(User, :count).by(0)
		expect(page).to have_content("This email is already taken")
	end

end

feature 'User signs in' do

	before(:each) do
		User.create(email: "test@test.com",
					password: 'test',
					password_confirmation: 'test')
	end

	scenario 'with correct credentials' do
		visit '/'
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in("test@test.com", 'test')
		expect(page).to have_content("Welcome, test@test.com")
	end

	scenario 'with incorrect credentials' do
		visit '/'
		expect(page).not_to have_content("Welcome, test@test.com")
		sign_in("test@test.com", 'wrong')
		expect(page).not_to have_content("Welcome, test@test.com")
	end

end

feature 'User signs out' do

	before(:each) do
		User.create(email: "test@test.com",
					password: "test",
					password_confirmation: 'test')
	end

	scenario 'while being signed in' do
		sign_in('test@test.com', 'test')
		click_button "Sign out"
		expect(page).to have_content("Good bye!")  # where does this message go?
		expect(page).not_to have_content("Welcome, test@test.com")
	end

end

feature 'User forgets their password' do

	before(:each) do
		@user = User.create(email: "test@test.com",
					password: "test",
					password_confirmation: 'test')

	end

	scenario 'and follows reset link within an hour' do
		visit '/sessions/new'
		fill_in 'email_reset', with: 'test@test.com'
		click_button "Reset"
		expect(page).to have_content("You've been sent an email with a link to reset your password")
		token = User.first(email: "test@test.com").password_token
		visit "/users/reset_password?token=#{token}"
		expect(page).to have_content("Hello #{@user.email}, your password has been reset. Please enter your new password:")
	end

	scenario 'and follows reset link after an hour' do
		visit '/sessions/new'
		fill_in 'email_reset', with: 'test@test.com'
		click_button "Reset"
		expect(page).to have_content("You've been sent an email with a link to reset your password")
		user = User.first(email: "test@test.com")
		token = user.password_token
		user.password_token_timestamp -= 3601 #doesn't seem to be updating the user db record? see User.all
		visit "/users/reset_password?token=#{token}"
		expect(page).to have_content("Sorry #{@user.email}, your reset link has expired. Would you like to request a new one?")
	end

end



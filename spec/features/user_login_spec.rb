# spec/features/user_login_spec.rb
require 'rails_helper'

RSpec.feature "User Login", type: :feature do
  let(:user) { create(:user, email: "user@example.com", password: "password") }

  scenario "User logs in successfully" do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"

    expect(page).to have_content("Mini-Blog\nWelcome, Test User\nPosts\nNew Post")
  end
end

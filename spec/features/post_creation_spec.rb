# spec/features/post_creation_spec.rb
require 'rails_helper'

RSpec.feature "Post Creation", type: :feature do
  let(:user) { create(:user) }

  before do
    visit new_user_session_path
    fill_in "Email", with: user.email
    fill_in "Password", with: "password"
    click_button "Log in"
  end

  scenario "User creates a new post" do
    visit root_path
    click_button "New Post"
    fill_in "post_title", with: "My First Post"
    fill_in "post_body", with: "This is the content of my first post."
    click_button "Create Post"

    expect(page).to have_content("Mini-Blog\nWelcome, Test User\nPosts\nNew Post\nMy First Post\nThis is the content of my first post.\nBy Test User\nPosted October 25, 2024 at 02:55 PM\nView Comments (0)\nNo comments yet.\nAdd a Comment")
  end
end

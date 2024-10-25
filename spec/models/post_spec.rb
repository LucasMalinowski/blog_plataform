# spec/models/post_spec.rb
require 'rails_helper'

RSpec.describe Post, type: :model do

  describe "pg_search_scope" do
    let!(:user) { create(:user, name: "Test User") }
    let!(:post) { create(:post, title: "Searchable Title", body: "This is a searchable body", user: user) }

    it "returns posts matching the title" do
      expect(Post.search_by_title_and_body_and_user_name("Searchable")).to include(post)
    end

    it "returns posts matching the body" do
      expect(Post.search_by_title_and_body_and_user_name("searchable body")).to include(post)
    end

    it "returns posts matching the user's name" do
      expect(Post.search_by_title_and_body_and_user_name("Test User")).to include(post)
    end

    it "does not return posts that don't match the query" do
      expect(Post.search_by_title_and_body_and_user_name("Nonexistent")).to be_empty
    end
  end
end

# frozen_string_literal: true
# spec/controllers/posts_controller_spec.rb
require 'rails_helper'

RSpec.describe PostsController, type: :controller do
  let(:user) { create(:user) }
  let(:post) { create(:post, user: user) }

  before do
    sign_in user
  end

  describe "GET #index" do
    context "without query params" do
      it "returns all posts" do
        get :index
        expect(assigns(:posts)).to include(post)
      end
    end

    context "with query params" do
      it "returns filtered posts" do
        get :index, params: { query: post.title }
        expect(assigns(:posts)).to include(post)
      end
    end
  end

  describe "PATCH #update" do
    context "with valid attributes" do
      it "updates the post" do
        patch :update, params: { id: post.id, post: { title: "Updated Title", body: "Updated body" } }
        expect(response).to redirect_to(post)
        post.reload
        expect(post.title).to eq("Updated Title")
        expect(post.body.to_html.strip).to eq("<p>Updated body</p>")
      end
    end
  end

  describe "DELETE #destroy" do
    it "deletes the post" do
      post
      expect {
        delete :destroy, params: { id: post.id }
      }.to change(Post, :count).by(-1)
      expect(response).to redirect_to(posts_path)
    end
  end
end

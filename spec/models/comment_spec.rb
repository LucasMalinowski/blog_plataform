# spec/models/comment_spec.rb
require 'rails_helper'

RSpec.describe Comment, type: :model do
  describe "callbacks" do
    let(:post) { create(:post) }
    let(:comment) { build(:comment, post: post, user: post.user) }

    it "calls send_notification after create" do
      expect(comment).to receive(:send_notification)
      comment.save
    end
  end
end

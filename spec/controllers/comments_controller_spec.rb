require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:post) { create(:post) }
  let!(:comment) { create(:comment, post: post, user: post.user) }

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the comment' do
        patch :update, params: { post_id: post.id, id: comment.id, comment: { body: 'Updated comment' } }
        comment.reload
        expect(comment.body.to_html.strip).to eq('<p>Updated comment</p>')
      end
    end
  end

  describe 'DELETE #destroy' do
    it 'deletes the comment' do
      comment_to_delete = create(:comment, post: post, user: post.user)
      expect {
        delete :destroy, params: { post_id: post.id, id: comment_to_delete.id }
      }.to change(Comment, :count).by(-1)
    end
  end
end

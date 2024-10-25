require 'rails_helper'

RSpec.describe CommentsController, type: :controller do
  let!(:post) { create(:post) }
  let!(:comment) { create(:comment, post: post, user: post.user) }

  describe 'POST #create' do
    context 'with valid params' do
      it 'creates a new comment' do
        expect {
          post :create, params: { post_id: post.id, comment: { body: 'New comment' } }
        }.to change(Comment, :count).by(1)
        expect(response).to redirect_to(posts_path)
      end
    end

    context 'with invalid params' do
      it 'renders errors' do
        post :create, params: { post_id: post.id, comment: { body: '' } }
        expect(response).to be_successful
        expect(assigns(:comment).errors).not_to be_empty
      end
    end
  end

  describe 'PATCH #update' do
    context 'with valid params' do
      it 'updates the comment' do
        patch :update, params: { post_id: post.id, id: comment.id, comment: { body: 'Updated comment' } }
        comment.reload
        expect(comment.body).to eq('Updated comment')
      end
    end

    context 'with invalid params' do
      it 'renders errors' do
        patch :update, params: { post_id: post.id, id: comment.id, comment: { body: '' } }
        expect(response).to be_successful
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

class CommentsController < ApplicationController
  def create
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.post = Post.find(params[:post_id])
    if @comment.save
      redirect_to posts_path
    else
      p @comment.errors.full_messages
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:body)
  end
end

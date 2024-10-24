class CommentsController < ApplicationController
  before_action :set_comment, only: %i[edit update destroy]

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

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("edit_comment_#{@comment.id}", partial: "comments/form", locals: { post: @comment.post, comment: @comment}),
          turbo_stream.replace("comment_#{@comment.id}_info", "")
        ]
      end
    end
  end

  def update
    if @comment.update(comment_params)
      respond_to do |format|
        format.html { redirect_to @comment, notice: 'Post was successfully updated.' }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(@comment, partial: "comments/comment", locals: { post: @comment.post, comment: @comment })]
        end
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_comment", partial: "comments/form", locals: { comment: @comment }) }
      end
    end
  end

  def destroy
    @comment.destroy
    redirect_to posts_path
  end

  private

  def set_comment
    @comment = Comment.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:body)
  end
end

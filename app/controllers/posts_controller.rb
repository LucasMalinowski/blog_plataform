class PostsController < ApplicationController
  before_action :set_post, only: %i[edit update destroy]

  def index
    @posts = if params[:query].present?
               Post.includes(:comments, :user)
                   .search_by_title_and_body_and_user_name(sanitize_sql(params[:query]))
                   .page(params[:page]).per(5)
             else
               Post.includes(:comments, :user)
                   .all.page(params[:page]).per(5)
             end
  end

  def show
  end

  def create
    post = Post.new(post_params)
    post.user = current_user
    post.save
    redirect_to posts_path
  end

  def edit
    respond_to do |format|
      format.html
      format.turbo_stream do
        render turbo_stream: [
          turbo_stream.replace("edit_post_#{@post.id}", partial: "posts/form", locals: { post: @post }),
          turbo_stream.replace("post_#{@post.id}_info", "")
        ]
      end
    end
  end

  def update
    if @post.update(post_params)
      respond_to do |format|
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.turbo_stream do
          render turbo_stream: [
            turbo_stream.replace(@post, partial: "posts/post", locals: { post: @post })]
        end
      end
    else
      respond_to do |format|
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_post", partial: "posts/form", locals: { post: @post }) }
      end
    end
  end

  def destroy
    @post.destroy
    redirect_to posts_path
  end

  private

  def set_post
    @post = Post.find(params[:id])
  end

  def post_params
    params.require(:post).permit(:title, :body, :images)
  end
end

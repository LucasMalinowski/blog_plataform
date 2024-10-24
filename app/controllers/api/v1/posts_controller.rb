module Api
  module V1
    class PostsController < ApplicationController
      before_action :set_post, only: [:show, :update, :destroy]
      skip_before_action :verify_authenticity_token

      def index
        @posts = if params[:query].present?
                   Post.search_by_title_and_body_and_user_name(params[:query])
                 else
                   Post.includes(:user, :comments).all
                 end

        # Format the response
        formatted_posts = @posts.map do |post|
          {
            id: post.id,
            title: post.title,
            markdown_body: post.markdown_body.body,
            user: {
              id: post.user.id,
              name: post.user.name,
              email: post.user.email
            },
            comments: post.comments.map do |comment|
              {
                id: comment.id,
                markdown_body: comment.markdown_body.body
              }
            end
          }
        end

        render json: formatted_posts
      end


      def show
        render json: @post, include: [:user, :comments, :markdown_body]
      end

      def create
        @post = Post.new(post_params)
        @post.user = current_user
        if @post.save
          render json: @post, status: :created
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def update
        if @post.update(post_params)
          render json: @post
        else
          render json: @post.errors, status: :unprocessable_entity
        end
      end

      def destroy
        @post.destroy
        head :no_content
      end

      private

      def set_post
        @post = Post.find(params[:id])
      end

      def post_params
        params.require(:post).permit(:title, :body)
      end
    end
  end
end

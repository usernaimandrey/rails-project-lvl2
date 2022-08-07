# frozen_string_literal: true

module Web
  class Posts::LikesController < Posts::ApplicationController
    before_action :duble_create_like, only: %i[create]
    before_action :duble_destroy_like, only: %i[destroy]

    def create
      @post = resources_post
      @like = @post.likes.build(like_params)
      if @like.save
        redirect_to post_path(@post)
      else
        @comment = @post.comments.build
        @comments = @post.comments.order(created_at: :desc)
        render 'web/posts/show', status: :unprocessable_entity
      end
    end

    def destroy
      @post = Post.find(params[:post_id])
      @like = @post.likes.find_by(id: params[:id])

      if @like.present? && @like.destroy
        redirect_to post_path(@post)
      else
        @comment = @post.comments.build
        @comments = @post.comments.order(created_at: :desc)
        render 'web/posts/show', status: :unprocessable_entity
      end
    end

    private

    def like_params
      { post_id: params[:post_id], user_id: current_user.id }
    end

    def liked?(post)
      post.likes.find_by(user_id: current_user).present?
    end

    def duble_create_like
      @post = resources_post
      return unless liked?(@post)
    end

    def duble_destroy_like
      @post = resources_post
      liked?(@post)
    end
  end
end

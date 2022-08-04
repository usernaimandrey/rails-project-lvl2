# frozen_string_literal: true

module Web
  class Posts::LikesController < Posts::ApplicationController
    def create
      @post = resources_post
      if liked?(@post)
        @comment = @post.comments.build
        @comments = @post.comments.order(created_at: :desc)
        render 'web/posts/show', status: :unprocessable_entity
        return
      else
        @like = @post.likes.build(like_params)
      end

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
      if liked?(@post)
        @like = @post.likes.find(params[:id])
      else
        redirect_to post_path(@post), status: :unprocessable_entity
      end

      if @like.destroy
        redirect_to post_path(@post)
      else
        redirect_to post_path(@post), status: :unprocessable_entity
      end
    end

    private

    def like_params
      { post_id: params[:post_id], user_id: current_user.id }
    end

    def liked?(post)
      post.likes.find_by(user_id: current_user).present?
    end
  end
end

# frozen_string_literal: true

module Web
  class Posts::LikesController < Posts::ApplicationController
    def create
      resource_post
      if liked?(@resource_post)
        redirect_to @resource_post
        return
      end

      @like = @resource_post.likes.build(like_params)
      if @like.save
        redirect_to @resource_post
        return
      end
      redirect_to @resource_post
    end

    def destroy
      resource_post
      unless liked?(resource_post)
        redirect_to @resource_post
        return
      end
      @like = @resource_post.likes.find_by(id: params[:id])

      if @like.destroy
        redirect_to @resource_post
        return
      end
      redirect_to @resource_post
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

# frozen_string_literal: true

module Web
  class Posts::LikesController < Posts::ApplicationController
    def create
      resource_post.likes.find_or_create_by(like_params)
      redirect_to resource_post
    end

    def destroy
      like = resource_post.likes.find_by(id: params[:id])
      like&.destroy
      redirect_to resource_post
    end

    private

    def like_params
      { user_id: current_user.id }
    end
  end
end

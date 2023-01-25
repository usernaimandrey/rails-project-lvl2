# frozen_string_literal: true

module Web
  module Posts
    module Comments
      class LikesController < Web::Posts::Comments::ApplicationController
        def create
          resource_post_comment.likes.find_or_create_by(like_params)
          redirect_to resource_post
        end

        def destroy
          like = resource_post_comment.likes.find_by(id: params[:id])
          like&.destroy
          redirect_to resource_post
        end

        private

        def like_params
          { user_id: current_user.id }
        end
      end
    end
  end
end

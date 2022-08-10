# frozen_string_literal: true

module Web
  class Posts::CommentsController < Posts::ApplicationController
    def create
      comment = resource_post.comments.build(comment_params)
      if comment.save
        redirect_to resource_post, notice: t('.success')
      else
        flash[:alert] = comment&.errors&.full_messages&.join
        redirect_to resource_post
      end
    end

    private

    def comment_params
      comment_params = params.require(:post_comment).permit(:content, :parent_id)
      comment_params.merge(user: current_user)
    end
  end
end

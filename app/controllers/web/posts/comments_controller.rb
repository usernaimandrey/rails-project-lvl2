# frozen_string_literal: true

module Web
  class Posts::CommentsController < Posts::ApplicationController
    def create
      resource_post
      if params[:parent_id]
        parent = PostComment.find(params[:parent_id])
        @comment = parent.children.build(comment_params.merge(post_id: @resource_post.id))
      else
        @comment = @resource_post.comments.build(comment_params)
      end

      if @comment.save
        redirect_to @resource_post, notice: t('.success')
      else
        flash[:alert] = @comment&.errors&.full_messages&.join
        redirect_to @resource_post
      end
    end

    private

    def comment_params
      comment_params = params.require(:post_comment).permit(:content)
      comment_params.merge(user_id: current_user.id)
    end
  end
end

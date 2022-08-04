# frozen_string_literal: true

module Web
  class Posts::CommentsController < Posts::ApplicationController
    def create
      @post = resources_post
      if params[:parent_id]
        parent = PostComment.find(params[:parent_id])
        @comment = parent.children.build(comment_params.merge(post_id: @post.id))
      else
        @comment = @post.comments.build(comment_params)
      end

      if @comment.save
        redirect_to post_path(@post), notice: t('.success')
      else
        flash.now[:alert] = t('.failure')
        @comments = @post.comments.order(created_at: :desc)
        render 'web/posts/show', status: :unprocessable_entity
      end
    end

    private

    def comment_params
      comment_params = params.require(:post_comment).permit(:content)
      comment_params.merge(user_id: current_user.id)
    end
  end
end

# frozen_string_literal: true

module Web
  class Posts::CommentsController < Posts::ApplicationController
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)

      if @comment.save
        redirect_to post_path(@post), notice: t('.success')
      else
        flash[:alert] = t('.failure')
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

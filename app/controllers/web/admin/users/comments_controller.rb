# frozen_string_literal: true

module Web
  class Admin::Users::CommentsController < Web::Admin::Users::ApplicationController
    def index
      @user = resource_user
      @comments = @user.comments
    end

    def destroy
      comment = resource_user.comments.find_by(id: params[:id])
      comment.destroy

      redirect_to admin_user_comments_path(resource_user)
    end
  end
end

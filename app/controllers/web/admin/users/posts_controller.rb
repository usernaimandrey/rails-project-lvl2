# frozen_string_literal: true

module Web
  class Admin::Users::PostsController < Web::Admin::Users::ApplicationController
    def index
      @user = resource_user
      @posts = @user.posts
    end

    def edit
      @user = resource_user
      @post = @user.posts.find_by(id: params[:id])
    end

    def update
      @user = resource_user
      @post = @user.posts.find_by(id: params[:id])

      if @post.update(post_params)
        flash[:notice] = t('.success')
        redirect_to action: :index
      else
        flash[:alert] = @post.errors.full_messages.join(' ')
        redirect_to edit_admin_user_post_path(@user, @post)
      end
    end

    def destroy
      post = resource_user.posts.find_by(id: params[:id])

      post.destroy
      flash[:notice] = t('.success')
      redirect_to action: :index
    end

    private

    def post_params
      params.require(:post).permit(:title, :body, :category_id)
    end
  end
end

# frozen_string_literal: true

module Web
  class PostsController < ApplicationController
    before_action :authenticate_user!, except: %i[show]

    def show
      @post = Post.find(params[:id])
      @comment = @post.comments.build
      @comments = @post.comments.order(created_at: :desc)
      @like = @post.likes.build
      @like_current_user = @post.likes.find_by(user_id: current_user)
    end

    def new
      @post = Post.new
    end

    def create
      @post = Post.new(post_params)

      if @post.save
        redirect_to root_path, notice: t('.succes')
      else
        flash.now[:alert] = t('.failure')
        render :new, status: :unprocessable_entity
      end
    end

    def destroy
      @post = Post.find(params[:id])
      if @post.creator_id != current_user.id
        flash[:alert] = t('.failure_permision')
        redirect_to post_path(@post), status: :unprocessable_entity
      elsif @post.destroy
        redirect_to root_path, notice: t('.succes')
      else
        flash[:alert] = t('.failure')
        redirect_to post_path(@post), status: :unprocessable_entity
      end
    end

    private

    def post_params
      post_params = params.require(:post).permit(:title, :body, :creator_id, :category_id)
      post_params.merge(creator_id: current_user.id)
    end
  end
end

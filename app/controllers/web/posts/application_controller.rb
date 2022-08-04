# frozen_string_literal: true

module Web
  class Posts::ApplicationController < ApplicationController
    before_action :authenticate_user!

    def resources_post
      Post.find(params[:post_id])
    end
  end
end

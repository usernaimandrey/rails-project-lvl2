# frozen_string_literal: true

module Web
  class Posts::ApplicationController < ApplicationController
    before_action :authenticate_user!

    def resource_post
      @resource_post ||= Post.find params[:post_id]
    end
  end
end

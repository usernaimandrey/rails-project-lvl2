# frozen_string_literal: true

module Web
  class HomeController < ApplicationController
    def index
      @posts = Post.includes(:creator).order(created_at: :desc)
    end
  end
end

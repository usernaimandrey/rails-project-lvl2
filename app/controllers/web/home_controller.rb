# frozen_string_literal: true

module Web
  class HomeController < ApplicationController
    def index
      @posts = Post.all
    end
  end
end

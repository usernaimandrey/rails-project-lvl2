# frozen_string_literal: true

module Web
  class Posts::ApplicationController < ApplicationController
    before_action :authenticate_user!
  end
end

# frozen_string_literal: true

module Web
  module Admin
    class UsersController < Web::Admin::ApplicationController
      def index
        @users = User.all
      end
    end
  end
end

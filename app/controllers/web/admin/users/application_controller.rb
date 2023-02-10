# frozen_string_literal: true

module Web
  class Admin::Users::ApplicationController < Web::Admin::ApplicationController
    def resource_user
      @resource_user ||= User.find_by(id: params[:user_id])
    end
  end
end

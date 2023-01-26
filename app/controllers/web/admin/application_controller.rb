# frozen_string_literal: true

module Web
  class Admin::ApplicationController < Web::ApplicationController
    before_action :authenticate_admin?

    def authenticate_admin?
      return if current_user.admin?

      flash[:alert] = t('.no_admin')
      redirect_to root_path
    end
  end
end

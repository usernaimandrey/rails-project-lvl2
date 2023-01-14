# frozen_string_literal: true

module Web
  module Account
    class NewslettersController < Web::Account::ApplicationController
      def edit; end

      def update
        user = current_user
        if user.update(news_letters_params)
          flash[:notice] = t('.succes')
          redirect_to edit_account_newsletters_path
        else
          flash[:alert] = t('.failure')
          render :edit
        end
      end

      private

      def news_letters_params
        params.require(:user).permit(:email_delivery_enabled)
      end
    end
  end
end

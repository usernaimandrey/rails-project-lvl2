# frozen_string_literal: true

module Web
  module Posts
    class Comments::ApplicationController < Web::Posts::ApplicationController
      def resource_post_comment
        @resource_post_comment ||= PostComment.find params[:comment_id]
      end
    end
  end
end

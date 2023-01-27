# frozen_string_literal: true

require 'test_helper'

class Web::Admin::UsersControllerTest < ActionDispatch::IntegrationTest
  test '#index' do
    admin = users(:pety)
    sign_in admin

    get admin_users_path

    assert_response :success
  end

  test '#index auth user' do
    user = users(:vasy)
    sign_in user

    get admin_users_path

    assert_redirected_to root_path
  end
end

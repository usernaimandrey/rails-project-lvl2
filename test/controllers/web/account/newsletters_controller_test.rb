# frozen_string_literal: true

require 'test_helper'

class Web::Account::NewslettersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:pety)
    sign_in @user
  end

  test '#edit' do
    get edit_account_newsletters_path
    assert_response :success
  end

  test '#update' do
    attrs = {
      email_delivery_enabled: 0
    }

    patch account_newsletters_path, params: { user: attrs }

    assert_redirected_to edit_account_newsletters_path
    assert { !@user.email_delivery_enabled }
  end
end

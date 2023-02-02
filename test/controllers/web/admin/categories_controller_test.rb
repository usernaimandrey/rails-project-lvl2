# frozen_string_literal: true

require 'test_helper'

class Web::Admin::CategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:pety)
    @category = categories(:js)
    @attrs = {
      name: 'Rust'
    }

    sign_in @admin
  end

  test '#index' do
    get admin_categories_path

    assert_response :success
  end

  test '#index with user not admin' do
    sign_out @admin
    user = users(:vasy)
    sign_in user

    get admin_categories_path

    assert_redirected_to root_path
  end

  test '#new' do
    get new_admin_category_path

    assert_response :success
  end

  test '#create' do
    post admin_categories_path, params: { category: @attrs }

    new_category = Category.find_by(@attrs)

    assert_redirected_to admin_categories_path
    assert { new_category }
  end

  test '#edit' do
    get edit_admin_category_path(@category)

    assert_response :success
  end

  test '#update' do
    patch admin_category_path(@category), params: { category: @attrs }

    @category.reload

    assert { @category.name == @attrs[:name] }
  end

  test '#destroy' do
    delete admin_category_path(@category)

    category_not_exist = Category.find_by(id: @category.id)

    assert { !category_not_exist }
  end
end

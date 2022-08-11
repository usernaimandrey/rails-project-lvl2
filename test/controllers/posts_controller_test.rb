# frozen_string_literal: true

require 'test_helper'

class PostsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:vasy)
    @post = posts(:one)
    sign_in @user
    @attributes = {
      title: Faker::Lorem.sentence,
      body: Faker::Lorem.paragraph_by_chars(number: 51, supplemental: false),
      category_id: categories(:ruby).id,
      creator: @user
    }
  end

  test '#show' do
    get post_path(@post)

    assert_response :success
  end

  test '#new' do
    get new_post_path

    assert_response :success
  end

  test '#new with not authorized' do
    sign_out @user
    get new_post_path

    assert_redirected_to new_user_session_path
  end

  test '#create' do
    post posts_path, params: { post: @attributes }
    new_post = Post.find_by(@attributes)

    assert_redirected_to root_path
    assert { new_post }
  end

  test '#create with not authorized' do
    sign_out @user
    post posts_path, params: { post: @attributes }
    new_post = Post.find_by(@attributes)

    assert_redirected_to new_user_session_path
    assert_not(new_post)
  end

  test '#create with invalid attributes' do
    @attributes.delete(:title)
    post posts_path, params: { post: @attributes }
    new_post = Post.find_by(@attributes)

    assert_response 422
    assert_not(new_post)
  end

  test '#destroy' do
    delete post_path(@post)

    assert_redirected_to root_path
    assert_not(Post.find_by(id: @post.id))
  end

  test '#destroy with not authorized' do
    sign_out @user
    delete post_path(@post)

    assert_redirected_to new_user_session_path
    assert { Post.find_by(id: @post.id) }
  end

  test '#destroy created by another user' do
    sign_out @user
    sign_in users(:pety)

    delete post_path(@post)

    assert_response 422
    assert { Post.find_by(id: @post.id) }
  end
end

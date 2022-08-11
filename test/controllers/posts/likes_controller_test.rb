# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:vasy)
    @post_without_likes = posts(:post_without_likes)
    @attributes = {
      user_id: @user.id,
      post_id: @post_without_likes.id
    }
    sign_in @user
  end

  test '#create' do
    post post_likes_path(@post_without_likes), params: @attributes
    new_like = PostLike.find_by(@attributes)

    assert_redirected_to post_path(@post_without_likes)
    assert { new_like }
  end

  test 'destroy' do
    post = posts(:one)
    like = post_likes(:one)
    delete post_like_path(post, like)

    delete_like = PostLike.find_by(id: like)

    assert_redirected_to post_path(post)
    assert_not(delete_like)
  end

  test '#create with not authorized' do
    sign_out @user
    post post_likes_path(@post_without_likes), params: @attributes
    new_like = PostLike.find_by(@attributes)

    assert_redirected_to new_user_session_path
    assert_not(new_like)
  end

  test 'double click on like' do
    post post_likes_path(@post_without_likes), params: @attributes
    @post_without_likes.reload
    likes_count = @post_without_likes.likes_count

    post post_likes_path(@post_without_likes), params: @attributes
    @post_without_likes.reload

    assert_response :redirect
    assert { likes_count == @post_without_likes.likes_count }
  end

  test 'double click on unlike' do
    post = posts(:one)
    like = post_likes(:one)
    delete post_like_path(post, like)
    post.reload
    likes_count = post.likes_count

    delete post_like_path(post, like)
    post.reload

    assert_response :redirect
    assert { likes_count == post.likes_count }
  end
end

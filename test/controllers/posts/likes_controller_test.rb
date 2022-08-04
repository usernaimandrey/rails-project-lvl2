# frozen_string_literal: true

require 'test_helper'

class LikesControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:vasy)
    @post_no_like = posts(:no_like_no_comment)
    @attributes = {
      user_id: @user.id,
      post_id: @post_no_like.id
    }
    sign_in @user
  end

  test '#create' do
    assert_difference @post_no_like.likes_count do
      post post_likes_path(@post_no_like), params: @attributes
    end
    new_like = Post::Like.find_by(@attributes)

    assert_redirected_to post_path(@post_no_like)
    assert { new_like }
  end

  test 'destroy' do
    post = posts(:one)
    like = post_likes(:one)
    assert_difference post.likes_count do
      delete post_like_path(post, like)
    end
    delete_like = Post::Like.find_by(id: like)

    assert_redirected_to post_path(post)
    assert_not(delete_like)
  end

  test '#create with not authorized' do
    sign_out @user
    assert_no_difference @post_no_like.likes_count do
      post post_likes_path(@post_no_like), params: @attributes
    end
    new_like = Post::Like.find_by(@attributes)

    assert_redirected_to new_user_session_path
    assert_not(new_like)
  end

  test '#creata duble like' do
    post post_likes_path(@post_no_like), params: @attributes

    assert_no_difference @post_no_like.likes_count do
      post post_likes_path(@post_no_like), params: @attributes
    end

    assert_response 422
  end
end

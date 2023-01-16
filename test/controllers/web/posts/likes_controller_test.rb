# frozen_string_literal: true

require 'test_helper'

class Web::Posts::LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:vasy)
    @post_without_likes = posts(:post_without_likes)
    sign_in @user
  end

  test '#create' do
    post post_likes_path(@post_without_likes)
    new_like = @post_without_likes.likes.find_by(user: @user)

    assert_redirected_to post_path(@post_without_likes)
    assert { new_like }
  end

  test '#destroy' do
    post = posts(:one)
    like = post_likes(:one)
    delete post_like_path(post, like)

    delete_like = PostLike.find_by(id: like)

    assert_redirected_to post_path(post)
    assert_not(delete_like)
  end

  test 'create with not authorized' do
    sign_out @user
    post post_likes_path(@post_without_likes)
    new_like = @post_without_likes.likes.find_by(user: @user)

    assert_redirected_to new_user_session_path
    assert_not(new_like)
  end

  test 'double click on like' do
    post post_likes_path(@post_without_likes)
    post post_likes_path(@post_without_likes)
    @post_without_likes.reload

    assert_response :redirect
    assert { @post_without_likes.likes_count == 1 }
  end

  test 'double click on unlike' do
    post = posts(:one)
    like = post_likes(:one)

    delete post_like_path(post, like)
    delete post_like_path(post, like)
    post.reload

    assert_response :redirect
    assert(post.likes_count.zero?)
  end
end

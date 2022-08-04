# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:pety)
    @post = posts(:no_like_no_comment)
    @attributes = {
      content: Faker::Lorem.sentence,
      user_id: @user.id,
      post_id: @post.id
    }
    sign_in @user
  end

  test '#create' do
    post post_comments_path(@post), params: { post_comment: @attributes }
    new_comment = Post::Comment.find_by(@attributes)

    assert { new_comment }
    assert_redirected_to post_path(@post)
  end

  test '#create nested comment' do
    comment = post_comments(:one)
    assert_not(comment.has_children?)

    post post_comments_path(@post), params: { parent_id: comment.id, post_comment: @attributes }
    new_comment = Post::Comment.find_by(@attributes)

    assert { new_comment }
    assert { comment.has_children? }
  end

  test '#create with invalid params' do
    @attributes.delete(:content)
    post post_comments_path(@post), params: { post_comment: @attributes }

    new_comment = Post::Comment.find_by(@attributes)

    assert_not(new_comment)
    assert_response 422
  end

  test '#create with not authorized' do
    sign_out @user
    post post_comments_path(@post), params: { post_comment: @attributes }

    new_comment = Post::Comment.find_by(@attributes)

    assert_not(new_comment)
    assert_redirected_to new_user_session_path
  end
end

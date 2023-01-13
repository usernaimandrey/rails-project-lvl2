# frozen_string_literal: true

require 'test_helper'

class CommentsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  setup do
    @user = users(:pety)
    @post = posts(:post_without_likes)
    @attributes = {
      content: Faker::Lorem.sentence
    }
    sign_in @user
  end

  test '#create' do
    post post_comments_path(@post), params: { post_comment: @attributes }
    new_comment = @post.comments.find_by(@attributes, user: @user)

    assert { new_comment }
    assert_redirected_to post_path(@post)
  end

  test '#create nested comment' do
    comment = post_comments(:one)
    assert_not(comment.has_children?)

    post post_comments_path(@post), params: { post_comment: @attributes.merge(parent_id: comment.id) }
    new_comment = comment.children.find_by(@attributes, user: @user)

    assert { new_comment }
    assert { comment.has_children? }
  end

  test '#create with invalid params' do
    @attributes[:content] = nil
    post post_comments_path(@post), params: { post_comment: @attributes }

    new_comment = @post.comments.find_by(@attributes, user: @user)

    assert_not(new_comment)
    assert_response :redirect
  end

  test '#create with not authorized' do
    sign_out @user
    post post_comments_path(@post), params: { post_comment: @attributes }

    new_comment = @post.comments.find_by(@attributes, user: @user)

    assert_not(new_comment)
    assert_redirected_to new_user_session_path
  end

  test 'new comment email' do
    post = posts(:one)
    assert_emails 1 do
      post post_comments_path(post), params: { post_comment: @attributes }
    end

    assert_redirected_to post_path(post)
  end

  test 'not send email when user author' do
    assert_emails 0 do
      post post_comments_path(@post), params: { post_comment: @attributes }
    end

    assert_redirected_to post_path(@post)
  end
end

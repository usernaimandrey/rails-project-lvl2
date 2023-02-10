# frozen_string_literal: true

class Web::Admin::Users::CommentsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:pety)
    @comment = post_comments(:one)
    @user = users(:vasy)

    sign_in @admin
  end

  test '#index_admin' do
    get admin_user_comments_path(@user)

    assert_response :success
  end

  test '#destroy_admin' do
    delete admin_user_comment_path(@user, @comment)

    comment = PostComment.find_by(id: @comment.id)
    assert { !comment }
    assert_redirected_to admin_user_comments_path(@user)
  end
end

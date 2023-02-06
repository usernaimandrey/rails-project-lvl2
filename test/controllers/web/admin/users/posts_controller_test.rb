# frozen_string_literal: true

class Web::Admin::Users::PostControllerTest < ActionDispatch::IntegrationTest
  setup do
    @admin = users(:pety)
    @post = posts(:one)
    @user = users(:vasy)

    sign_in @admin
  end

  test '#index' do
    get admin_user_posts_path(@user, @post)

    assert_response :success
  end

  test '#edit' do
    get edit_admin_user_post_path(@user, @post)

    assert_response :success
  end

  test '#update' do
    attrs = {
      title: Faker::Lorem.word
    }

    patch admin_user_post_path(@user, @post), params: { post: attrs }
    @post.reload

    assert_redirected_to admin_user_posts_path
    assert { @post.title == attrs[:title] }
  end

  test '#destroy' do
    delete admin_user_post_path(@user, @post)

    assert_redirected_to admin_user_posts_path

    assert { !Post.find_by(id: @post.id) }
  end
end

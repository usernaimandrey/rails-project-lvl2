# frozen_string_literal: true

class Web::Posts::Comments::LikesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:vasy)
    @comment_without_like = post_comments(:without_likes)
    @post = posts(:one)
    sign_in @user
  end

  test '#create' do
    post post_comment_likes_path(@post, @comment_without_like)

    new_like = @comment_without_like.likes.find_by(user: @user)

    assert_redirected_to @post
    assert { new_like }
  end

  test '#destroy' do
    like = likes(:two)
    post_comment = post_comments(:one)

    delete post_comment_like_path(@post, post_comment, like)

    assert_redirected_to @post
    assert_not(post_comment.likes.find_by(id: like.id))
  end

  test 'double click on like' do
    post post_comment_likes_path(@post, @comment_without_like)
    post post_comment_likes_path(@post, @comment_without_like)
    @comment_without_like.reload

    assert_response :redirect
    assert { @comment_without_like.likes_count == 1 }
  end

  test 'double click on unlike' do
    like = likes(:two)
    post_comment = post_comments(:one)

    delete post_comment_like_path(@post, post_comment, like)
    delete post_comment_like_path(@post, post_comment, like)
    post_comment.reload

    assert_response :redirect
    assert { post_comment.likes_count.zero? }
  end
end

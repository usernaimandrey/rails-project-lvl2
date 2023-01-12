# Preview all emails at http://localhost:3000/rails/mailers/new_post_comment_mailer
class NewPostCommentMailerPreview < ActionMailer::Preview
  def new_comment_email
    NewPostCommentMailer.with(comment: PostComment.last).new_comment_email
  end
end

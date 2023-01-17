# frozen_string_literal: true

# Preview all emails at http://localhost:3000/rails/mailers/new_ansestry_comment_mailer
class NewAnsestryCommentMailerPreview < ActionMailer::Preview
  def new_ansestry_comment_email
    comment = PostComment.last
    user = User.first
    NewAnsestryCommentMailer.with(user: user, comment: comment).new_ansestry_comment_email
  end
end

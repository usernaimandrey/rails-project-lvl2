class NewPostCommentMailer < ApplicationMailer
  def new_comment_email
    @comment = params[:comment]
    @creator = @comment.post.creator
    mail(to: @creator.email, subject: t('.subject_new_comment'))
  end
end

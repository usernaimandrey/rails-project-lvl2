# frozen_string_literal: true

class NewAnsestryCommentMailer < ApplicationMailer
  def new_ansestry_comment_email
    @comment = params[:comment]
    @user = params[:user]

    mail(to: @user.email, subject: t('.subject_new_comment'))
  end
end

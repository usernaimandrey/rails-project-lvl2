# frozen_string_literal: true

class MailSender
  class << self
    def send_new_comment_mail(comment)
      post = comment.post
      user = comment.user
      return unless can_send_email_notification?(user, post)

      NewPostCommentMailer.with(comment: comment).new_comment_email.deliver_later
    end

    def can_send_email_notification?(user, post)
      user.can_send_email? && !post.author?(user)
    end
  end
  private_class_method :can_send_email_notification? 
end
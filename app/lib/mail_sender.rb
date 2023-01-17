# frozen_string_literal: true

class MailSender
  class << self
    def send_new_comment_mail(comment)
      if comment.has_parent?
        send_email_new_ansestry_comment(comment)
      else
        send_email_new_comment_post(comment)
      end
    end

    def send_email_new_comment_post(comment)
      post = comment.post
      user = post.creator
      return unless can_send_email_notification?(user, comment)

      NewPostCommentMailer.with(comment: comment).new_comment_email.deliver_later
    end

    def send_email_new_ansestry_comment(comment)
      parent_comment = comment.parent
      user = parent_comment.user

      return unless can_send_email_notification?(user, comment)

      NewAnsestryCommentMailer.with(user: user, comment: comment).new_ansestry_comment_email.deliver_later
    end

    def can_send_email_notification?(user, comment)
      user.can_send_email? && !comment.author?(user)
    end
  end
  private_class_method :can_send_email_notification?
end

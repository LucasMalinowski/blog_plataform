class CommentMailer < ApplicationMailer
  default from: 'no-reply@yourapp.com'

  def new_comment_notification(post, comment)
    @post = post
    @comment = comment
    mail(to: post.user.email, subject: 'New Comment on Your Post')
  end
end

class CommentNotificationJob < ApplicationJob
  queue_as :default

  def perform(comment_id)
    comment = Comment.find(comment_id)
    post = comment.post

    CommentMailer.new_comment_notification(post, comment).deliver_later
  end
end

class Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post
  has_markdown :body

  after_create_commit :send_notification

  private

  def send_notification
    CommentNotificationJob.perform_later(self.id)
  end
end

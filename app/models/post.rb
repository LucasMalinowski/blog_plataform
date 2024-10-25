class Post < ApplicationRecord
  include PgSearch::Model

  has_markdown :body
  has_many_attached :images

  belongs_to :user
  has_many :comments, dependent: :destroy

  pg_search_scope :search_by_title_and_body_and_user_name,
                  associated_against: {
                    user: :name,
                    markdown_body: :body
                  },
                  against: [:title],
                  using: {
                    tsearch: { prefix: true }
                  }
end

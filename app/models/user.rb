class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :trackable, :validatable,
          :confirmable

  enum role: { guest: 0, author: 1 }

  has_many :posts
  has_many :comments
  has_one_attached :avatar

  validates :email, :name, presence: true

  def avatar_thumbnail
    avatar.attached? ? avatar : 'default_avatar.jpg'
  end
end

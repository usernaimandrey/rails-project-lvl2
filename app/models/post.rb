# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User', inverse_of: :posts
  belongs_to :category
  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy

  validates :title, :body, presence: true
  validates :body, length: { minimum: 50 }

  def author?(user)
    creator_id == user.id
  end
end

# frozen_string_literal: true

class PostComment < ApplicationRecord
  has_ancestry
  belongs_to :user
  belongs_to :post
  has_many :likes, as: :likeable, dependent: :destroy

  validates :content, presence: true

  def author?(user)
    user_id == user.id
  end
end

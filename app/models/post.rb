# frozen_string_literal: true

class Post < ApplicationRecord
  belongs_to :creator, class_name: 'User', inverse_of: :posts
  belongs_to :category
  has_many :comments, dependent: :destroy

  validates :title, :body, presence: true
  validates :body, length: { minimum: 50 }
end

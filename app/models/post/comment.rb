# frozen_string_literal: true

class Post::Comment < ApplicationRecord
  belongs_to :user
  belongs_to :post

  validates :content, presence: true
end

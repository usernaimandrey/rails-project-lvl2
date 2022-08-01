# frozen_string_literal: true

class Post::Comment < ApplicationRecord
  has_ancestry
  belongs_to :user
  belongs_to :post

  validates :content, presence: true
end

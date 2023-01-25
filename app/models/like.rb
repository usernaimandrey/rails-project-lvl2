# frozen_string_literal: true

class Like < ApplicationRecord
  belongs_to :likeable, polymorphic: true, counter_cache: :likes_count
  belongs_to :user

  validates :likeable_type, presence: true
end

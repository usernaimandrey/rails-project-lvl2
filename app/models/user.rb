# frozen_string_literal: true

class User < ApplicationRecord
  # :confirmable, :lockable, :recoverable, :validatable :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :posts, foreign_key: 'creator_id', inverse_of: :creator, dependent: :destroy
  has_many :comments, class_name: 'Post::Comment', dependent: :destroy
  has_many :likes, class_name: 'PostLike', dependent: :destroy
end

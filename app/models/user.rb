# frozen_string_literal: true

class User < ApplicationRecord
  # :confirmable, :lockable, :recoverable, :validatable :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable

  has_many :posts, dependent: :destroy, foreign_key: 'creator_id', inverse_of: :creator
end

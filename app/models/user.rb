# frozen_string_literal: true

class User < ApplicationRecord
  extend Enumerize
  # :confirmable, :lockable, :recoverable, :validatable :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :confirmable, :recoverable, :registerable, :lockable,
         :rememberable, :trackable, :validatable, :trackable

  has_many :posts, foreign_key: 'creator_id', inverse_of: :creator, dependent: :destroy
  has_many :comments, class_name: 'PostComment', dependent: :destroy
  has_many :likes, dependent: :destroy

  enumerize :role, in: %i[user admin], default: :user, predicates: true

  def initialize(attribute = nil)
    default = {
      email_delivery_enabled: true
    }
    attribute_with_default = attribute ? default.merge(attribute) : default
    super(attribute_with_default)
  end

  def can_send_email?
    email_delivery_enabled && !unconfirmed_email
  end
end

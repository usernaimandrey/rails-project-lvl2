# frozen_string_literal: true

class User < ApplicationRecord
  # :confirmable, :lockable, :recoverable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :validatable
end

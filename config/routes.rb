# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: :passwords

  scope module: :web do
    root 'home#index'
  end
end

# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: :passwords

  scope module: :web do
    root 'home#index'

    resources :posts, only: %i[show new create destroy] do
      scope module: :posts do
        resources :comments, only: %i[create]
        resources :likes, only: %i[create destroy]
      end
    end
  end
end

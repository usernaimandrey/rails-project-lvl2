# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  scope module: :web do
    root 'home#index'

    resources :posts, only: %i[show new create destroy] do
      scope module: :posts do
        resources :comments, only: %i[create]
        resources :likes, only: %i[create destroy]
      end
    end

    namespace :account do
      resource :newsletters, only: %i[edit update]
    end
  end
end

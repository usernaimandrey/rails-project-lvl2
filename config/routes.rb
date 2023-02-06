# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  scope module: :web do
    root 'home#index'

    resources :posts, only: %i[show new create destroy] do
      scope module: :posts do
        resources :comments, only: %i[create] do
          scope module: :comments do
            resources :likes, only: %i[create destroy]
          end
        end
        resources :likes, only: %i[create destroy]
      end
    end

    namespace :account do
      resource :newsletters, only: %i[edit update]
    end

    namespace :admin do
      resources :users, only: :index do
        scope module: :users do
          resources :posts, only: %i[index edit update destroy]
        end
      end
      resources :categories, only: %i[index new create edit update destroy]
    end
  end
end

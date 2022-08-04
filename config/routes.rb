# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: :passwords,
                     controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  scope module: :web do
    root 'home#index'

    resources :posts, only: %i[show new create destroy] do
      scope module: :posts do
        post 'comments(/:parent_id)', to: 'comments#create', as: :comments
        resources :likes, only: %i[create destroy]
      end
    end
  end
end

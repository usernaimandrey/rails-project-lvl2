# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: :passwords,
                     controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  scope module: :web do
    root 'home#index'

    resources :posts, only: %i[show new create destroy] do
      scope module: :posts do
        # resources :comments, only: %i[create]
        post 'comments(/:parent_id)', to: 'comments#create', as: :comments
      end
    end
  end
end

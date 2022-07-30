# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users, skip: :passwords,
                     controllers: { sessions: 'users/sessions', registrations: 'users/registrations' }

  scope module: :web do
    root 'home#index'

    resources :posts, except: %i[index] do
      scope module: :posts do
        resources :comments, only: %i[create]
      end
    end
  end
end

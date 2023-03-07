# frozen_string_literal: true

require 'sidekiq/web'

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Redirect www traffic
  match '(*any)', to: redirect(subdomain: ''), via: :all, constraints: { subdomain: 'www' }

  # Errors
  match '/404', to: 'errors#not_found', via: :all
  match '/500', to: 'errors#internal_server_error', via: :all

  # Authentication
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  # Profile verification
  devise_scope :user do
    get 'user/verify', to: 'users/registrations#verify'
  end

  # Authenticated routes
  authenticated do
    # Defines the root path route ("/")
    root to: 'dashboard#index', as: :authenticated_root

    # Two factor authentication
    resource :two_factor_settings, except: %i[index show]
  end

  # Star Network views
  get 'dashboard', to: 'dashboard#index'

  # Admin routes
  authenticated :user, ->(user) { user.admin? } do
    # Sidekiq
    Sidekiq::Web.app_url = '/'
    mount Sidekiq::Web => '/sidekiq'
  end

  # Marketing
  get 'home', to: 'home#index'

  root to: 'home#index'
end

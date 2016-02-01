Rails.application.routes.draw do
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  devise_scope :user do
    get 'sign_in', :to => 'devise/sessions#new', :as => :new_user_session
    get 'sign_out', :to => 'devise/sessions#destroy', :as => :destroy_user_session
  end

  root to: 'home#landing'

  get '/home', to: 'home#show', as: :home

  resources :challenges do
    collection do
      get :new_from_segment
      get :search_segments
    end

    member do
      put :join
    end
  end
end

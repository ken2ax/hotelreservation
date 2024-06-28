Rails.application.routes.draw do
  get 'home/index'
  get 'rooms/search', to: 'rooms#search', as: 'search_rooms'
  get 'rooms/area_search', to: 'rooms#area_search', as: 'area_search_rooms'

  devise_for :users, controllers: {
    passwords: 'users/passwords',
    registrations: 'users/registrations',
    sessions: 'users/sessions'
  }

  devise_scope :user do
    get '/users/sign_out' => 'devise/sessions#destroy'
  end

  root to: "home#index"

  resources :users, only: [:edit, :update] do
    member do
      get :mypage
      get :account
      get :show_room
      get :show_reservation
    end
  end

  resources :rooms, except: [:show] do
    member do
      get :detail
    end
    resources :reservations, only: [:new, :create] do
      collection do
        post :confirm
      end
    end
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

Rails.application.routes.draw do
  devise_for :users,
    path: '',
    path_names: {
      sign_in: 'login',
      sign_out: 'logout',
      registration: 'signup'
    },
    controllers: {
      sessions: 'users/sessions',
      registrations: 'users/registrations'
    }

    resources :barbers, only: [:index] do
      get 'available_times', on: :member
    end
    resources :appointments, only: [:create, :index,:update ,:destroy]
    resources :working_hours, only: [:index, :create, :update, :destroy]

    namespace :barbers do
      resources :appointments, only: [:index]
    end

    namespace :me do
      get 'barber', to: 'barbers#show'
      put 'barber', to: 'barbers#update'
      put 'password', to: 'users#update_password'
    end

  # Sağlık durumu (opsiyonel)
  get "up" => "rails/health#show", as: :rails_health_check

  # root path tanımı yok çünkü API modundayız
end



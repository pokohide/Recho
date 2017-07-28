require 'sidekiq/web'
# rubocop:disable Metrics/BlockLength
Rails.application.routes.draw do
  get 'users/account'

  get 'users/show'

  mount Sidekiq::Web => '/sidekiq'
  mount ActionCable.server => '/cable'
  mount LetterOpenerWeb::Engine, at: '/letter_opener' if Rails.env.development?

  root 'root#index'

  devise_for :users, path_names: { sign_in: 'login', sign_out: 'logout' },
                     controllers: { omniauth_callbacks: 'omniauth_callbacks' }

  get '/account', to: 'users#account', as: :account
  get '/about', to: 'root#about', as: :about
  get '/contact', to: 'root#contact', as: :contact

  get '/:username', to: 'users#show', as: :user
end

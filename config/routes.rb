Rails.application.routes.draw do
  devise_for :users
  root 'root#index'
  get '/about', to: 'root#about', as: :about
  get '/contact', to: 'root#contact', as: :contact
end

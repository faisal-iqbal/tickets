Rails.application.routes.draw do
  root 'tickets#index'
  get "/404" => "errors#not_found"
  get "/500" => "errors#exception"
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  devise_for :users
  namespace :api do
    devise_for :users
  end  
  
  resources :tickets
  post 'tickets/:id/mark_close' => 'tickets#mark_close', as: :close_ticket
  post 'tickets/:id/reopen' => 'tickets#reopen', as: :reopen_ticket

  resources :comments

  resources :members
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

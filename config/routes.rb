Rails.application.routes.draw do

  root :to => 'home#index'
  get 'home/about'

  # Grape API
  mount RootApi => '/api'
end

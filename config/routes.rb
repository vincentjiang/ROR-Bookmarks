Rails.application.routes.draw do

  root 'home#index'
  get 'home/about'

  # Grape API
  mount RootApi => '/api'
end

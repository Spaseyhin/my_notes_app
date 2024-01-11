Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  get 'notes/index'
  get 'notes/show'
  get 'notes/new'
  get 'notes/create'
  get 'notes/edit'
  get 'notes/update'
  get 'notes/destroy'
  resources :notes
  root 'notes#index'
end

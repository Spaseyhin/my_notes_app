Rails.application.routes.draw do
  mount ActionCable.server => "/cable"
  get 'notes/index'
  get 'notes/show'
  get 'notes/new'
  get 'notes/create'
  get 'notes/edit'
  get 'notes/update'
  get 'notes/destroy'
  resources :notes do
   patch 'complete', on: :member
   patch 'incomplete', on: :member
  end
  root 'notes#index'
end

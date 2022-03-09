Rails.application.routes.draw do
  devise_for :users
  rootto: 'homes#top', as: "root"
  get 'searches/search'
  get 'discuss_records/new'
  get 'discuss_records/show'
  get 'discuss_records/edit'
  get 'discuss_records/congratulations'
  get 'discuss_records/index'
  get 'pairs/edit'
  get 'pairs/invite'
  get 'pairs/complete'
  get 'pairs/confirm'
  get 'users/edit'
  get 'users/confirm'
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

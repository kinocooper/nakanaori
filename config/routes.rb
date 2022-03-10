Rails.application.routes.draw do
  devise_for :users
  root to: 'homes#top', as: "root"
  get "about" => "homes#about", as: "about"

  resource :users, only:[:edit,:update]
  get 'users/confirm' ,as: "u_confirm"
  patch 'users/disabling' => "users#disabling", as: "disabling"

  resource :pairs, only:[:edit,:update,:destroy] #create的なものはregistration#createでまとめる予定
  get 'pairs/invite', as: "invite"
  post "pairs/send", as: "send"
  get 'pairs/complete', as: "complete"
  get 'pairs/confirm', as: "p_confirm"

  resources :discuss_records, only:[:new,:create,:show,:edhit,:index,:destroy] do
    resources :personal_opinions, only:[:update]
  end
  patch "discuss_records/reconcile", as: "reconcile"
  get 'discuss_records/congratulations', as: "congratulations"

  resources :tags, only:[:new,:create,:destroy]

  resources :tag_relationships, only:[:create,:destroy]

  get 'searches/search'
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

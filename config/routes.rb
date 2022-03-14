Rails.application.routes.draw do
  get "about" => "homes#about", as: "about"

  resource :user, only:[:edit,:update]
  get 'users/confirm' ,as: "u_confirm"
  patch 'users/disabling' => "users#disabling", as: "disabling"

  # deviseをマッピングするがデフォルトルーティングは全skip、必要なアクションだけ個別にルーティング
  devise_for :user, skip: :all
  devise_scope :user do
    get 'sing_up' => 'devise/registrations#new', as: :new_user_registration
    post 'sing_up' => 'devise/registrations#create', as: :user_registration
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  resource :pair, only:[:new,:create,:edit,:update,:destroy]
  root to: 'pairs#top', as: "root"
  get "pairs/introduction", as: "introduction"
  get "pairs/join", as: "join"
  patch "pairs/pairing", as: "pairing"
  get 'pairs/invite', as: "invite"
  post "pairs/send", as: "send"
  get 'pairs/complete', as: "complete"
  get 'pairs/confirm', as: "p_confirm"

  get 'discuss_records/congratulations', as: "congratulations"
  resources :discuss_records, only:[:new,:create,:index,:show,:edit,:update,:destroy]#do
    # resources :personal_opinions, only:[:update]　←ナカナオリ直前にまとめ意見だけを編集するようなページを作るなら必要
  # end
  patch "discuss_records/:id/reconcile" => "discuss_records#reconcile", as: "reconcile"

  resources :tags, only:[:new,:create,:destroy]

  resources :tag_relationships, only:[:create,:destroy]

  get 'searches/search'
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

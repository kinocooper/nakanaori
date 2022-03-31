Rails.application.routes.draw do
  # homes
  get "about" => "homes#about", as: "about"

  # users
  resource :user, only:[:edit,:update]
  get 'users/confirm' ,as: "u_confirm"
  patch 'users/disabling' => "users#disabling", as: "disabling"

  # devise
  # deviseをマッピングするがデフォルトルーティングは全skip、必要なアクションだけ個別にルーティング
  devise_for :user, skip: :all
  devise_scope :user do
    get 'sign_up' => 'devise/registrations#new', as: :new_user_registration
    post 'sign_up' => 'devise/registrations#create', as: :user_registration
    get 'login' => 'devise/sessions#new', as: :new_user_session
    post 'login' => 'devise/sessions#create', as: :user_session
    delete 'logout' => 'devise/sessions#destroy', as: :destroy_user_session
  end

  # pairs
  resource :pair, only:[:new,:create,:edit,:update,:destroy]
  root to: 'pairs#top', as: "root"
  # get "pairs/introduction", as: "introduction"  newに集約
  get "pairs/join", as: "join"
  patch "pairs/pairing", as: "pairing"
  get 'pairs/invite', as: "invite"
  get "pairs/send_mail", as: "send_mail"
  get 'pairs/complete', as: "complete"
  get 'pairs/confirm', as: "p_confirm"

  # discuss_records
  get 'discuss_records/congratulations', as: "congratulations"
  resources :discuss_records, only:[:new,:create,:index,:show,:edit,:update,:destroy] #do
    # resources :personal_opinions, only:[:update]　←ナカナオリ直前にまとめ意見だけを編集するようなページを作るなら必要
    # resources :tag_relationships, only:[:create,:destroy]
  #end
  patch "discuss_records/:id/reconcile" => "discuss_records#reconcile", as: "reconcile"

  # tags
  resources :tags, only:[:show,:create,:destroy]

  # tag_relationships
  post "discuss_records/:discuss_record_id/tags/:tag_id/tag_relationships" => "tag_relationships#create", as: "tag_relationships"
  delete "discuss_records/:discuss_record_id/tags/:tag_id/tag_relationships" => "tag_relationships#destroy", as: "tag_relationshis"

  # searches
  get 'searches/search'
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

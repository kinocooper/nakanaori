Rails.application.routes.draw do
  # homes
  get "about" => "homes#about", as: "about"

  # users
  resource :user, only:[:edit,:update] do
    collection do
      get 'confirm'
      patch 'disabling'
    end
  end

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
  root to: 'pairs#top', as: "root"
  resource :pair, only:[:new,:create,:edit,:update,:destroy] do
    collection do
      # 以下 pair/"×××"
      get "confirm"
      get "join"
      get "invite"
      get "send_mail"
      get "complete"
      patch "pairing"
    end
  end

  # discuss_records
  resources :discuss_records do
    # resources :personal_opinions, only:[:update]　←ナカナオリ直前にまとめ意見だけを編集するようなページを作るなら必要
    # resources :tag_relationships, only:[:create,:destroy]
    member do
      patch "reconcile"
      get 'congratulations'
    end
  end

  # tags
  resources :tags, only:[:index,:show,:create,:destroy]

  # tag_relationships
  post "discuss_records/:discuss_record_id/tags/:tag_id/tag_relationships" => "tag_relationships#create", as: "new_tag_relationships"
  delete "discuss_records/:discuss_record_id/tags/:tag_id/tag_relationships" => "tag_relationships#destroy", as: "destroy_tag_relationships"

  # searches
  get 'searches/search'
 # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

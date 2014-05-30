Rails.application.routes.draw do
  root :to => "organizations#index"

  resources :organizations, only: [:index, :show, :edit, :update, :new, :create] do
    get 'claim', on: :member
    post 'toggle_hiring', on: :member
    put 'add_role', on: :member
    delete 'destroy_role', on: :member
  end

  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/auth0", as: "login"

  resources :users, only: [:show, :update, :edit]

  get "/verify_email_callback" => "auth0#verify_email_callback"
  get "/sessions/set" => "sessions#set", as: "set_session"
  get "/sessions/unset" => "sessions#unset", as: "unset_session"

  resources :profile_links, only: [:create, :update, :destroy]

  get 'tags/:tag', to: 'organizations#index', as: :tag
  post 'tag/:organization_id', to: 'tags#create', as: "create_tag"
  delete 'tag/:organization_id/:tag_id', to: 'tags#destroy', as: "destroy_tag"

  resources :activities, only: [:index]

  resources :addresses, only: [:update, :create]
end

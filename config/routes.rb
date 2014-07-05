Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  root to: "activities#index"

  get "/search", to: "search#index"
  get "/search/organizations", to: "search#search_organizations"
  get "/search/people", to: "search#search_users", as: "search_users"


  get "/about", to: 'pages#about'
  get "/contact", to: 'pages#contact'

  get "/offices", to: 'pages#offices'
  get "/events", to: 'pages#events'

  get "/internationaljobs", to: 'pages#internationaljobs'

  resources :organizations, only: [:index, :show, :edit, :update, :new, :create] do
    get "claim", on: :member
    post "toggle_hiring", on: :member
  end

  get "/auth/auth0/callback", to: "auth0#callback"
  get "/auth/auth0", as: "login"

  resources :users, only: [:show, :update, :edit] do
    get "claim", on: :member
  end

  get "/people", to: "users#index", as: "users"

  get "/verify_email_callback", to: "auth0#verify_email_callback"
  get "/sessions/set", to: "sessions#set", as: "set_session"
  get "/sessions/unset", to: "sessions#unset", as: "unset_session"

  resources :profile_links, only: [:create, :update, :destroy]

  post "tag/:organization_id", to: "tags#create", as: "create_tag"
  delete "tag/:organization_id/:tag_id", to: "tags#destroy", as: "destroy_tag"
  post "user_tag/:user_id", to: "tags#create_user_tag", as: "create_user_tag"
  delete "user_tag/:user_id/:tag_id", to: "tags#destroy_user_tag", as: "destroy_user_tag"

  post ":organization_id/add_role", to: "organization_user_roles#create", as: "add_role"
  delete ":organization_id/remove_role/:id", to: "organization_user_roles#destroy", as: "remove_role"

  post ":organization_id/add_type", to: "types#add_to_organization", as: "add_type"
  delete ":organization_id/remove_type/:type_id", to: "types#remove_from_organization", as: "remove_type"

  resources :activities, only: [:index]

  resources :addresses, only: [:update, :create]

  post "users/:id/email_digest_subscription", to: "users#toggle_email_digest_subscription", as: "toggle_email_digest_subscription"

  get "users/unsubscribe/:signature", to: "users#unsubscribe", as: "unsubscribe"
end

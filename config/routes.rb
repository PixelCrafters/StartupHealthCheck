Rails.application.routes.draw do
  root to: "activities#index"

  get "/search", to: "search#index"

  resources :organizations, only: [:index, :show, :edit, :update, :new, :create] do
    get "claim", on: :member
    post "toggle_hiring", on: :member
  end

  get "/auth/auth0/callback", to: "auth0#callback"
  get "/auth/auth0", as: "login"

  resources :users, only: [:show, :update, :edit]

  get "/people", to: "users#index", as: "users"

  get "/verify_email_callback", to: "auth0#verify_email_callback"
  get "/sessions/set", to: "sessions#set", as: "set_session"
  get "/sessions/unset", to: "sessions#unset", as: "unset_session"

  resources :profile_links, only: [:create, :update, :destroy]

  get "tags/:tag", to: "organizations#index", as: :tag
  post "tag/:organization_id", to: "tags#create", as: "create_tag"
  delete "tag/:organization_id/:tag_id", to: "tags#destroy", as: "destroy_tag"

  post ":organization_id/add_role", to: "organization_user_roles#create", as: "add_role"
  delete ":organization_id/remove_role/:id", to: "organization_user_roles#destroy", as: "remove_role"

  post ":organization_id/add_type", to: "types#add_to_organization", as: "add_type"
  delete ":organization_id/remove_type/:type_id", to: "types#remove_from_organization", as: "remove_type"

  resources :activities, only: [:index]

  resources :addresses, only: [:update, :create]

  post "users/:id/email_digest_subscription", to: "users#toggle_email_digest_subscription", as: "toggle_email_digest_subscription"
end

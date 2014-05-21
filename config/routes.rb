Rails.application.routes.draw do
  root :to => "organizations#index"

  resources :organizations, only: [:index, :show, :edit, :update] do
    get 'claim', on: :member
    post 'toggle_hiring', on: :member
  end

  get "/auth/auth0/callback" => "auth0#callback"
  get "/auth/auth0", as: "login"

  resources :users, only: [:show, :update, :edit]

  get "/sessions/set" => "sessions#set", as: "set_session"
  get "/sessions/unset" => "sessions#unset", as: "unset_session"

  resources :profile_links, only: [:create, :update, :destroy]

  get 'tags/:tag', to: 'organizations#index', as: :tag
  delete 'tag/:organization_id/:tag_id', to: 'organizations#destroy_tag', as: "destroy_tag"

  resources :activities, only: [:index]
end

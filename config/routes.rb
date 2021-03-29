Rails.application.routes.draw do
  devise_for :admin_users, ActiveAdmin::Devise.config
  ActiveAdmin.routes(self)
  resources :tweets do
    post 'likes', to:"tweets#like"
    post 'retweet', to:"tweets#retweet"
  end
  devise_for :users
  root to:"tweets#index"

  get 'home/profile', to: 'home#profile'
  get 'home/tweets', to: 'home#tweets'
  post 'home/:id/follow', to: "home#follow", as: "follow_user"
  delete 'home/:id/unfollow', to: "home#unfollow", as: "unfollow_user"
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end

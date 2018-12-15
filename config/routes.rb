Rails.application.routes.draw do
  namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :user, only: :create
      post "setting" => "setting#show"
      post "search" => "search#show"
    end
  end
end

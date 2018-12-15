Rails.application.routes.draw do
 namespace :api, {format: 'json'} do
    namespace :v1 do
      resources :user, only: :create
    end
  end
end

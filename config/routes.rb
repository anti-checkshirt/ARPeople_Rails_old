Rails.application.routes.draw do
  namespace :api, {format: 'json'} do
    namespace :v1 do
      post "register" => "user#create"
      post "login" => "user#login"
      post "user" => "user#show"
      put "user" => "user#update"
      post "user_image" => "user#image"
      post "images" => "setting#show"
      post "search" => "search#show"
      get 'test' => 'api#index'
    end
  end
end

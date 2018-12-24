Rails.application.routes.draw do
  namespace :api, {format: 'json'} do
    namespace :v1 do
      post "register" => "user#create"
      post "images" => "setting#show"
      post "search" => "search#show"
      put "register" => "user#update"
    end
  end
end

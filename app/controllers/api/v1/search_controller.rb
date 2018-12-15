
class Api::V1::SearchController < ApplicationController

  def create
 
    @user = User.new(name: params[:name], email: params[:email],password: params[:password_digest],age: params[:age], twitter: params[:Twitter_ID],github: params[:Github_ID],image: params[:user_image_url])
    if @user.save 
        render json: @user
     else 
        render json: '{"404":"Not Found"}'  
　  end
  end


end
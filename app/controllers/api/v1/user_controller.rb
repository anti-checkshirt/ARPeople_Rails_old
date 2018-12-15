require 'securerandom'

class Api::V1::UserController < ApplicationController
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password_digest: params[:password],
      age: params[:age],
      Twitter_ID: params[:twitterID],
      Github_ID: params[:githubID],
      user_image_url: params[:userImage]
      )
    if @user.save
        render json: @user
    else 
        render json: '{"404":"Not Found"}'
　  end
  end
end

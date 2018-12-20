require 'securerandom'

class Api::V1::UserController < ApplicationController
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password_digest: params[:password],
      age: params[:age],
      twitter_id: params[:twitterID],
      github_id: params[:githubID],
      user_image_url: params[:userImage],
      person_id: params[:personID]
      )
    if @user.save
        render json: @user
    else 
        render json: '{"404":"Not Found"}'
　  end
  end
end

require 'securerandom'

class Api::V1::UserController < ApplicationController
  def create
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password_digest: params[:password],
      age: params[:age],
      user_image_url: params[:userImage],
      twitter_id: nil,
      github_id: nil,
      person_id: nil
      )
    if @user.save
        render json: @user
    else 
        render json: '{"404":"Not Found"}'
　  end
  end
  def update
    @user = User.find_by(id: params[:id])
    if @user.nil?
      render json: '{"404":"User not found."}'
    else
      @user.twitter_id = params[:twitterID]
      @user.github_id = params[:githubID]
      @user.save
      render :json '{"200":"Update User."}'
    end
  end
end

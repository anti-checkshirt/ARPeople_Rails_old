require 'securerandom'

class User < ActiveRecord::Base
  has_secure_token :access_token
end

class Api::V1::UserController < ApplicationController
  def create
    @uuid = SecureRandom.urlsafe_base64(32)
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password_digest: params[:password],
      age: nil,
      user_image_url: nil,
      twitter_id: nil,
      github_id: nil,
      person_id: nil,
      uuid: @uuid
      )
    if @user.save
      render json: @user
    else 
      response_bad_request
　  end
  end
  def update
    @id = params[:id]
    if @id.nil?
      # パラメータにidが含まれていない時
      response_bad_request
    else
      @user = User.find_by(id: @id)
      if @user.nil?
        # userが存在しない時
        response_not_found('user')
      else
        @user.twitter_id = params[:twitterID]
        @user.github_id = params[:githubID]
        @user.save
        response_success(:user, :update)
      end
    end
  end

  def login

  end
  
  def user

  end

  def image

  end
end

require 'securerandom'

class User < ActiveRecord::Base
  has_secure_token :access_token
end

class Api::V1::UserController < ApplicationController
  # 新規登録
  def create
    @uuid = SecureRandom.urlsafe_base64(32)
    @user = User.new(
      name: params[:name],
      email: params[:email],
      password_digest: params[:password],
      age: "",
      user_image_url: "",
      twitter_id: "",
      github_id: "",
      person_id: "",
      uuid: @uuid
      )
    if @user.save
      render json: @user
    else 
      response_bad_request
　  end
  end

  # アカウント情報変更
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

  # ログイン
  def login

  end
  
  #ユーザーのアカウント取得
  def user

  end

  # プロフィール画像登録
  def image

  end
end

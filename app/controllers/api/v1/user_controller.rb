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
    @token = request.headers["Authorization"]
    @user = User.find_by(access_token: @token)
    if @user == nil 
      response_bad_request
    end
    @user.name = params[:name]
    @user.email = params[:email]
    @user.twitter_id = params[:twitterID]
    @user.github_id = params[:githubID]
    @user.age = params[:age]

    if @user.save
      render json: @user
    else
      response_internal_server_error
    end
  end

  # ログイン
  def login
    # メールアドレスの検索
    # パスワード検索
  end
  
  #ユーザーのアカウント取得
  def data
    # Headerからアクセストークンを取る
    # Tokenを検索
    # userを返す
    @token = request.header["TOKEN"]
    puts request.header
    @user = find_by(access_token: @token)
    p @user
    render @user
  end

  # プロフィール画像登録
  def image
    # Headerからユーザーを特定
    # 画像を保存する
    # URLを返す
  end
end

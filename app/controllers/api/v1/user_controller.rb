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
      return render json: @user
    else
      return response_bad_request
　  end
  end

  # アカウント情報変更
  def update
    @token = request.headers["Authorization"]
    @user = User.find_by(access_token: @token)
    if @user == nil
      return response_bad_request
    end
    @user.name = params[:name]
    @user.email = params[:email]
    @user.twitter_id = params[:twitterID]
    @user.github_id = params[:githubID]
    @user.age = params[:age]

    if @user.save
      return render json: @user
    else
      return response_internal_server_error
    end
  end

  # ログイン
  def login
    @user = User.find_by(email: params[:email], password_digest: params[:password])
    if @user
      return render json: @user
    else
      return response_bad_request
    end
  end
  
  #ユーザーのアカウント取得
  def show
    @user = User.find_by(access_token: request.headers["Authorization"])
    if @user
      return render json: @user
    else
      return response_bad_request
    end
  end

  # プロフィール画像登録
  def image
    # Headerからユーザーを特定
    # 画像を保存する
    # URLを返す
    @token = request.headers["Authorization"]
    @user = User.find_by(access_token: @token)
    if @user == nil?
      return response_bad_request
    else
      @uuid = @user.uuid
      @save_dir = "public/#{@uuid}"
      FileUtils.mkdir_p(@save_dir) unless FileTest.exist?(@save_dir)


      @image_name = SecureRandom.uuid
      @image = params[:image]
      @image_name = "#{@image_name}.jpeg"
      @save_path = "#{@save_dir}/#{@image_name}"
      File.binwrite(@save_path, @image.read)
      @user.user_image_url = "http://#{request.host_with_port}/#{@uuid}/#{@image_name}"
      if @user.save
        return render json: "http://#{request.host_with_port}/#{@uuid}/#{@image_name}"
      else
        return response_internal_server_error
      end
    end

    
  end
end

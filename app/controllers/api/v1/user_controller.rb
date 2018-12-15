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

  def show
    image_key_names = [params[:image1], params[:image2], params[:image3], params[:image4], params[:image5], params[:image6], params[:image7], params[:image8], params[:image9], params[:image10]]
    image_key_names.each do |image_key_name|
      File.binwrite("public/#{params[:id]}/#{SecureRandom.uuid}", image.read)
    end
  end
end

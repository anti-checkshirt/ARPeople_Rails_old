require 'securerandom'

class Api::V1::SettingController < ApplicationController
    def show
        image_key_names = [params[:image1], params[:image2], params[:image3], params[:image4], params[:image5], params[:image6], params[:image7], params[:image8], params[:image9], params[:image10]]
        image_key_names.each do |image_key_name|
            image = image_key_name
            File.binwrite("public/#{params[:id]}/#{SecureRandom.uuid}.jpg", image.read)
        end
    end
end

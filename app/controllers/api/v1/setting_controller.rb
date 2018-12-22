require 'securerandom'
require 'net/http'
require 'json'
class Api::V1::SettingController < ApplicationController

    # グループにPersonを登録
    def create_person(person_name)
        uri = URI("https://japaneast.api.cognitive.microsoft.com/face/v1.0/persongroups/test_dayo/persons")
        uri.query = URI.encode_www_form({
        })
        request = Net::HTTP::Post.new(uri.request_uri)
        request['Content-Type'] = 'application/json'
        request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']
        request.body = "{'name': '#{person_name}'}"
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end
        return JSON.parse(response.body)["personId"]
    end

    def add_face(person_id, image_url)
        uri = URI("https://japaneast.api.cognitive.microsoft.com/face/v1.0/persongroups/test_dayo/persons/#{person_id}/persistedFaces")
        uri.query = URI.encode_www_form({
            'userData' => 'user-provided data attached to the person group.',
        })
        request = Net::HTTP::Post.new(uri.request_uri)
        request['Content-Type'] = 'application/json'
        request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']
        request.body = "{'url': '#{image_url}'}"
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end
        return response.body
    end

    def train()
        uri = URI("https://japaneast.api.cognitive.microsoft.com/face/v1.0/persongroups/test_dayo/train")
        uri.query = URI.encode_www_form({
        })
        request = Net::HTTP::Post.new(uri.request_uri)
        request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end
        return response.body
    end

    def show
        image_params = [params[:image1],
                        params[:image2],
                        params[:image3],
                        params[:image4],
                        params[:image5],
                        params[:image6],
                        params[:image7],
                        params[:image8],
                        params[:image9],
                        params[:image10]]
                        
        # 本来はこっちでやる
        # user_id = params[:user_id]
        user_id = 1
        person_id = create_person(user_id)
        @user = User.find(user_id)
        if @user.nil?
            render json: '{"404":"User not found."}'
        else
            @user.person_id = person_id
            @user.save
            image_params.each do |image_param|
                uuid = SecureRandom.uuid
                @image = image_param
                @image_name = "#{uuid}+jpeg"
                save_path = "public/#{user_id}/#{@image_name}"
                File.binwrite(save_path, @image.read)
                add_face(person_id,
                    "http://192.168.100.19:3000/api/v1/image/?user_id=#{user_id}&image_name=#{@image_name}")
            end
            train()
        end
    end
end

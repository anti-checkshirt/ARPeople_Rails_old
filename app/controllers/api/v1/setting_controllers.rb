require 'securerandom'
require 'net/http'
require 'json'
class Api::V1::SettingController < ApplicationController

    # グループにPersonを登録
    def create_person(person_name)
        uri = URI("https://japaneast.api.cognitive.microsoft.com/face/v1.0/persongroups/ar_people/persons")
        uri.query = URI.encode_www_form({
        })
        request = Net::HTTP::Post.new(uri.request_uri)
        # Request headers
        request['Content-Type'] = 'application/json'
        # Request headers
        request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']
        # Request body
        request.body = "{'name': '#{person_name}'}"
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end
        
        return JSON.parse(response.body)["personId"]
    end

    def add_face(person_id, image_url)
        uri = URI("https://japaneast.api.cognitive.microsoft.com/face/v1.0/persongroups/ar_people/persons/#{person_id}/persistedFaces")
        uri.query = URI.encode_www_form({
            # Request parameters
            'userData' => 'user-provided data attached to the person group.',
        })
        request = Net::HTTP::Post.new(uri.request_uri)
        # Request headers
        request['Content-Type'] = 'application/json'
        # Request headers
        request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']
        # Request body
        request.body = "{'url': '#{image_url}'}"
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end

        return response.body
    end

    def train()
        uri = URI("https://japaneast.api.cognitive.microsoft.com/face/v1.0/persongroups/ar_people/train")
        uri.query = URI.encode_www_form({
        })
        request = Net::HTTP::Post.new(uri.request_uri)
        # Request headers
        request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end
        return response.body
    end

    def show
        image_key_names = [params[:image1], params[:image2], params[:image3], params[:image4], params[:image5], params[:image6], params[:image7], params[:image8], params[:image9], params[:image10]]
        person_id = create_person(params[:id])

        image_key_names.each do |image_key_name|
            uuid = SecureRandom.uuid
            image = image_key_name
            path = "public/#{params[:id]}/#{uuid}.jpg"
            File.binwrite(path, image.read)

            # 以下よりAzureAPIへの処理
            person_id = create_person(params[:id])
            add_face(person_id, root_url(only_path: false)+path)
            @user = User.find(params[:id])
            @user.Person_ID = person_id
            @user.save
        end
        train()
        render json: '{"200":"Status OK."}'
    end
end

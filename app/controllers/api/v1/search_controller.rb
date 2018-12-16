require 'net/http'
require 'json'
require 'securerandom'
class Api::V1::SearchController < ApplicationController
  
    def detect_face(image_url)
        uri = URI('https://japaneast.api.cognitive.microsoft.com/face/v1.0/detect')
        uri.query = URI.encode_www_form({
            # Request parameters
            'returnFaceId' => 'true',
            'returnFaceLandmarks' => 'false',
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
        p JSON.parse(response.body)
        return JSON.parse(response.body)[0]["faceId"]
    end

    def identify_person(detected_faceId)
        uri = URI('https://japaneast.api.cognitive.microsoft.com/face/v1.0/identify')
        uri.query = URI.encode_www_form({
        })
        
        request = Net::HTTP::Post.new(uri.request_uri)
        # Request headers
        request['Content-Type'] = 'application/json'
        # Request headers
        request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']
        # Request body
        request.body = "{'personGroupId': 'ar_people', 'faceIds': ['#{detected_faceId}'], 'maxNumOfCandidatesReturned': 1, 'confidenceThreshold': 0.5 }"
        p request.body
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end
        return JSON.parse(response.body)
    end

    def get_name_by_person_id(person_id)
        uri = URI("https://japaneast.api.cognitive.microsoft.com/face/v1.0/persongroups/ar_people/persons/#{person_id}")
        uri.query = URI.encode_www_form({
        })
        request = Net::HTTP::Get.new(uri.request_uri)
        # Request headers
        request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']
        # Request body
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end
        
        puts response.body
    end
    
    def show
      image = params[:image]
      uuid = SecureRandom.uuid
      # フォルダ名は適当。意味はない。
      path = "public/test_image/#{uuid}.jpeg"
      File.binwrite(path, image.read)
      face_id = detect_face(root_url(only_path: false)+path)
      person_id = identify_person(face_id)[0]["candidates"][0]["personId"]
      @user = User.find_by(personId: person_id)
      if @user.nil?
        render json: '{"404":"Not found."}'
      else
        render json: @user
        File.delete(path)
      end
    end
end

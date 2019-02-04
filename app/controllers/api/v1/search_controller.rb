# frozen_string_literal: true

require 'net/http'
require 'json'
require 'securerandom'
class Api::V1::SearchController < ApplicationController
  # image_url内から顔のみを切り取る
  def detect_face(image_url)
    uri = URI(Settings.ar_people.detect)
    uri.query = URI.encode_www_form(
      # Request parameters
      'returnFaceId' => 'true',
      'returnFaceLandmarks' => 'false'
    )
    request = Net::HTTP::Post.new(uri.request_uri)

    # headerをセット
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']

    request.body = "{'url': '#{image_url}'}"
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
    return JSON.parse(response.body)[0]['faceId']
  end

  # 切り取った顔の画像を判定する
  def identify_person(detected_faceId)
    uri = URI(Settings.ar_people.identify_person)
    uri.query = URI.encode_www_form({
                                    })

    request = Net::HTTP::Post.new(uri.request_uri)

    # headerをセット
    request['Content-Type'] = 'application/json'
    request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']

    request.body = "{'personGroupId': 'test_people', 'faceIds': ['#{detected_faceId}'], 'maxNumOfCandidatesReturned': 1, 'confidenceThreshold': 0.5 }"
    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end
    return JSON.parse(response.body)
  end

  # identify_personから返ってきたperson_idから名前を取得する
  def get_name_by_person_id(person_id)
    uri = URI(Settings.ar_people.get_name_by_person_id+person_id)
    uri.query = URI.encode_www_form({
                                    })
    request = Net::HTTP::Get.new(uri.request_uri)

    # headerをセット
    request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']

    response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == 'https') do |http|
      http.request(request)
    end

    return JSON.parse(response.body)
  end

  def show
    @image = params[:image]
    if @image.nil?
      # パラメータにimageが含まれない時
      response_bad_request
    else
      # ランダムな文字列を生成
      @uuid = SecureRandom.urlsafe_base64(32)
      @image_name = "#{@uuid}.jpeg"
      @save_dir = "public/#{@uuid}"

      # フォルダが存在しない場合生成
      # フォルダが既に存在する場合は何もしない
      FileUtils.mkdir_p(@save_dir) unless FileTest.exist?(@save_dir)
      @save_path = "#{@save_dir}/#{@image_name}"
      # 画像の保存
      File.binwrite(@save_path, @image.read)

      # 顔を切り取ってその顔のface_idを受け取る
      @face_id = detect_face(
        "http://#{request.host_with_port}/#{@uuid}/#{@image_name}"
      )

      # 顔の判定をし、判定結果を受け取る
      @person_id = identify_person(@face_id)[0]['candidates'][0]['personId']

      @id = get_name_by_person_id(@person_id)['name']

      # @idがUserにあるか探す
      @user = User.find_by(id: @id)

      if @user.nil?
        # userが存在しない時
        response_not_found('user')
      else
        user = {
            :name => @user.name,
            :email => @user.email,
            :twitter_id => @user.twitter_id,
            :github_id => @user.github_id,
            :age => @user.age,
            :job => @user.job,
            :profile_message => @user.profile_message,
            :profile_number => @user.phone_number
        }

        render json: user
        File.delete(path)
      end
    end
  end

  def authenticate
    authenticate_or_request_with_http_token do |token, _options|
      @auth_user = User.find_by(access_token: token)
      !@auth_user.nil? ? true : false
    end
  end
end

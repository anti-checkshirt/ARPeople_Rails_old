require 'securerandom'
require 'net/http'
require 'json'
class Api::V1::SettingController < ApplicationController

    # グループにPersonを登録
    def create_person(person_name)
        uri = URI("https://japaneast.api.cognitive.microsoft.com/face/v1.0/persongroups/test_people/persons")
        uri.query = URI.encode_www_form({
        })
        request = Net::HTTP::Post.new(uri.request_uri)

        # headerをセット
        request['Content-Type'] = 'application/json'
        request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']

        request.body = "{'name': '#{person_name}'}"
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end
        return JSON.parse(response.body)["personId"]
    end

    # Personに学習したい顔を追加
    def add_face(person_id, image_url)
        uri = URI("https://japaneast.api.cognitive.microsoft.com/face/v1.0/persongroups/test_people/persons/#{person_id}/persistedFaces")
        uri.query = URI.encode_www_form({
            'userData' => 'user-provided data attached to the person group.',
        })
        request = Net::HTTP::Post.new(uri.request_uri)

        # headerをセットs
        request['Content-Type'] = 'application/json'
        request['Ocp-Apim-Subscription-Key'] = ENV['AZURE_TOKEN']

        request.body = "{'url': '#{image_url}'}"
        response = Net::HTTP.start(uri.host, uri.port, :use_ssl => uri.scheme == 'https') do |http|
            http.request(request)
        end
        return response.body
    end

    # 学習開始
    def train()
        uri = URI("https://japaneast.api.cognitive.microsoft.com/face/v1.0/persongroups/test_people/train")
        uri.query = URI.encode_www_form({
        })
        request = Net::HTTP::Post.new(uri.request_uri)

        # headerをセット
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
        if user_id.nil?
          # パラメータにuser_idが含まれない時
          response_bad_request
        else
          @user = User.find_by(id: user_id)
          @save_dir = "public/#{user_id}"
          if @user.nil?
              # userが存在しない時
              response_not_found('user')
          else
            @person_id = create_person(user_id)

            # フォルダが既に存在する場合は何もしない
            FileUtils.mkdir_p(@save_dir) unless FileTest.exist?(@save_dir)

            # Userにperson_idを保存する
            @user.person_id = @person_id
            @user.save

            image_params.each do |image_param|
              # ランダムな文字列を生成
              uuid = SecureRandom.uuid
              
              @image = image_param
              @image_name = "#{uuid}.jpeg"
              @save_path = "#{@save_dir}/#{@image_name}"
              File.binwrite(@save_path, @image.read)
              
              # 画像のURLをMSのAPIに投げる
              add_face(@person_id,
                "http://ip:3000/#{user_id}/#{@image_name}")
            end
            
            # 学習開始
            train()
            response_success(:setting, :show)
          end
        end
    end
end

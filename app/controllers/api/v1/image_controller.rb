
class Api::V1::ImageController < ApplicationController
  def show
    image_name = params[:image_name]
    user_id = params[:user_id]
    path = "/#{user_id}/#{image_name}"
    render :html => "<img src='#{path}'>".html_safe
  end
end

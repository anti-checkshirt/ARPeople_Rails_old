
class Api::V1::ImageController < ApplicationController
  def show
    @image_name = params[:image_name]
    @user_id = params[:user_id]
    if @image_name.nil? or @user_id.nil?
      response_bad_request
    else
      @path = "/#{@user_id}/#{@image_name}"
      render :html => "<img src='#{@path}'>".html_safe
    end
  end
end

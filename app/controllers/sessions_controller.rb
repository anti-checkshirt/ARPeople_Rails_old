class SessionsController < ApplicationController
  def new
  end

  def creare
    email = params[:session][:email].downcase
    password = params[:session][:password]
  end

  def destroy
    session[:user_id] = nil
    flash[:success] = 'ログアウトしました。'
    redirect_to root_url
  end
end

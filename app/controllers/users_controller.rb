class UsersController < ApplicationController
  def index
    @users = User.all.page(params[:page])
  end

  def show
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
  end

  def update
  end

  def edit
  end

  def destroy
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, : )

  end
end

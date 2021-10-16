class UsersController < ApplicationController
  before_action :user_check, only: [:show]

  def show
    @user = User.find(params[:id])
  end

  private

  def user_check
    user = User.find(params[:id])
    if current_user.id != user.id
      redirect_to reviews_path, notice: "権限がありません"
    end
  end
end

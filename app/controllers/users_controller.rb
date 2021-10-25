class UsersController < ApplicationController
  before_action :user_check, only: [:show]

  def show
    @user = User.find(params[:id])
    @reviews = @user.reviews
    @lovew_reviews = @user.lovew_reviews
    @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(10)
    @lovew_reviews = Kaminari.paginate_array(@lovew_reviews).page(params[:page]).per(10)
  end

  private

  def user_check
    user = User.find(params[:id])
    if current_user.id != user.id
      redirect_to reviews_path, notice: "権限がありません"
    end
  end
end

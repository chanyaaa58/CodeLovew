class LovewsController < ApplicationController
  # def index
  #   @lovew = Lovew.all
  # end

  def create
    lovew = current_user.lovews.build(review_id: params[:review_id])
    lovew.save
    redirect_to reviews_path, notice: "#{lovew.review.user.name}さんのブログをお気に入り登録しました"
  end

  def destroy
    lovew = Lovew.find_by(review_id: params[:review_id], user_id: current_user.id)
    lovew.destroy
    redirect_to reviews_path, notice: "#{lovew.review.user.name}さんのブログをお気に入り解除しました"
  end
end

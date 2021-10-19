class LovewsController < ApplicationController
  def index
    @lovew = Lovew.all
  end

  def create
    lovew = current_user.lovews.create(review_id: params[:review_id])
    redirect_to reviews_path, notice: "#{lovew.review.user.name}さんのブログをお気に入り登録しました"
  end

  def destroy
    lovew = current_user.lovews.find_by(id: params[:id]).destroy
    redirect_to reviews_path, notice: "#{lovew.review.user.name}さんのブログをお気に入り解除しました"
  end
end

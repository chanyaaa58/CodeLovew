class CommentsController < ApplicationController
  # コメントを保存、投稿するためのアクションです。
  def create
    # reviewをパラメータの値から探し出し,reviewに紐づくcommentsとしてbuildします。
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(comment_params)
    # クライアント要求に応じてフォーマットを変更
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to review_path(@review), notice: '投稿できませんでした...' }
      end
    end
  end
  private
  # ストロングパラメーター
  def comment_params
    params.require(:comment).permit(:review_id, :content)
  end
end
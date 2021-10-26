class CommentsController < ApplicationController
  before_action :set_review, only: [:create, :edit, :update]
  def create
    @comment = @review.comments.build(comment_params)
    @comment.user_id = current_user.id

    respond_to do |format|
      if @comment.save
        format.html { redirect_to review_path(@review) }
      else
        format.html { redirect_to review_path(@review), notice: '何らかの理由で投稿できませんでした。' }
      end
    end
  end

  def edit
    @comment = @review.comments.find(params[:id])
    respond_to do |format|
      format.js { render :edit }
    end
  end

  def update
    @comment = @review.comments.find(params[:id])
      respond_to do |format|
        if @comment.update(comment_params)
          format.js { render :index }
        else
          format.js { render :edit_error }
        end
      end
  end

  def destroy
    @comment = Comment.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.js { render :index }
    end
  end

  private

  def comment_params
    params.require(:comment).permit(:content,:review_id, :user_id)
  end

  def set_review
    @review = Review.find(params[:review_id])
  end
end
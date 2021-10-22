class CommentsController < ApplicationController
  before_action :set_review, only: [:create, :edit, :update]
  def create
    @review = Review.find(params[:review_id])
    @comment = @review.comments.build(comment_params)
    respond_to do |format|
      if @comment.save
        format.js { render :index }
      else
        format.html { redirect_to review_path(@review) }
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
    params.require(:comment).permit(:review_id, :content)
  end

  def set_review
    @review = Review.find(params[:review_id])
  end
end
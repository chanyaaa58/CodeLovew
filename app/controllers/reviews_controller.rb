class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: %i[ show edit update destroy ]
  before_action :check_review_user, only: %i(edit update destroy)

  def index
    @q = Review.ransack(params[:q])
    @reviews = @q.result(distinct: true).order(created_at: :desc)
    flash.now[:alert] = "検索結果はありませんでした" if @reviews.count == 0
    @reviews = @reviews.joins(:labels).where(labels: { id: params[:label_id] }).page(params[:page]).per(10).reorder(created_at: :desc) if params[:label_id].present?
    @reviews = Kaminari.paginate_array(@reviews).page(params[:page]).per(10)
    flash.now[:alert] = "引き続きご利用いただき、ありがとうございます！！" if params[:cancel_quit]
  end

  def show
    @comments = @review.comments
    @comment = Comment.new
    @comments = @review.comments.order(created_at: :desc)
    @lovew = current_user.lovews.find_by(review_id: @review.id)
  end

  def new
    @review = Review.new
  end

  def edit
  end

  def create
    @review = current_user.reviews.build(review_params)
    @review.user_id = current_user.id

    if @review.save
      redirect_to reviews_path, notice: "レビューを投稿しました。"
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: "投稿を更新しました。" }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "投稿を削除しました。" }
      format.json { head :no_content }
    end
  end

  # def search
  #   @search = Review.ransack(params[:q])
  #   @results = @search.result.order(created_at: :desc)
  #   @results = Kaminari.paginate_array(@results).page(params[:page]).per(10)
  #   redirect_to reviews_path, alert: '検索結果は0件です。' if @results == []
  # end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:title, :problem, :detail, :solution, :content, { label_ids: [] })
    end
  def check_review_user
    if @review.user != current_user
      redirect_to reviews_path, notice: "権限がありません"
    end
  end
end

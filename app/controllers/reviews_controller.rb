class ReviewsController < ApplicationController
  before_action :authenticate_user!, except: [:index]
  before_action :set_review, only: %i[ show edit update destroy ]

  def index
    @q = Review.ransack(params[:q])
    @reviews = @q.result(distinct: true)
    @reviews = @reviews.joins(:labels).where(labels: { id: params[:label_id] }).page(params[:page]) if params[:label_id].present?
    @reviews = Kaminari.paginate_array(@reviews).page(params[:page])
    flash.now[:alert] = "引き続きご利用いただき、ありがとうございます！！" if params[:cancel_quit]
  end

  def show
    @comments = @review.comments
    @comment = @review.comments.build
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

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: "レビューを投稿しました。" }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
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

  def search
    @search = Review.ransack(params[:q])
    @results = @search.result
    @results = Kaminari.paginate_array(@results).page(params[:page])
  end

  private

    def set_review
      @review = Review.find(params[:id])
    end

    def review_params
      params.require(:review).permit(:name, :title, :problem, :detail, :solution, :content, { label_ids: [] })
    end
end

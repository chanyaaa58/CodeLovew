class ReviewsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_review, only: %i[ show edit update destroy ]
  # before_action :set_q, only: [:index, :search]

  # GET /reviews or /reviews.json
  def index
    @q = Review.ransack(params[:q])
    @reviews = @q.result(distinct: true)
    @reviews = @reviews.joins(:labels).where(labels: { id: params[:label_id] }) if params[:label_id].present?
  end

  # GET /reviews/1 or /reviews/1.json
  def show
    @comments = @review.comments
    @comment = @review.comments.build
    @lovew = current_user.lovews.find_by(review_id: @review.id)
  end

  # GET /reviews/new
  def new
    @review = Review.new
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews or /reviews.json
  def create
    # @review = Review.new(review_params)
    @review = current_user.reviews.build(review_params)
    @review.user_id = current_user.id

    respond_to do |format|
      if @review.save
        format.html { redirect_to @review, notice: "Review was successfully created." }
        format.json { render :show, status: :created, location: @review }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1 or /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to @review, notice: "Review was successfully updated." }
        format.json { render :show, status: :ok, location: @review }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1 or /reviews/1.json
  def destroy
    @review.destroy
    respond_to do |format|
      format.html { redirect_to reviews_url, notice: "Review was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def search
    @search = Review.ransack(params[:q])
    @results = @search.result.order("created_at DESC")
  end

  private

  # 　def set_q
  #   　@q = Review.ransack(params[:q])
  # 　end
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def review_params
      params.require(:review).permit(:name, :title, :problem, :detail, :solution, :content, { label_ids: [] })
    end
end

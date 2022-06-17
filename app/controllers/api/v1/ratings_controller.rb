class Api::V1::RatingsController < ApplicationController
  before_action :set_rating, only: [:show, :update, :destroy]

  # GET /ratings
  def index
    if params[:project_id]

      @project_ratings = Rating.where(:project_id => params[:project_id])

      if params[:rater_id]
        @project_ratings = @project_ratings.where(:user_id => params[:rater_id])
      end

      render json: @project_ratings.order(:created_at).reverse()

    else
      @ratings = Rating.all
      render json: @ratings
    end


  end

  # GET /ratings/1
  def show
    render json: @rating
  end

  # POST /ratings
  def create
    @rating = Rating.new(rating_params)

    if @rating.save
      send_email if rating_params[:feedbacks_attributes].present? && !rating_params[:feedbacks_attributes].length.zero?

      q = Reviewqueue.where(:project_id => @rating.project_id, :user_id => rating_params[:user_id]).first
      if q != nil
        q.destroy
      end
      render json: @rating, status: :created
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ratings/1
  def update
    if @rating.update(rating_params)
      render json: @rating
    else
      render json: @rating.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ratings/1
  def destroy
    @rating.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rating
      @rating = Rating.find(params[:id])
    end

  def send_email
    project = Project.find(rating_params['project_id'])
    MandrillUserMailer.recent_rates(@rating, project, I18n.locale).deliver_now
  end

    # Only allow a trusted parameter "white list" through.
    def rating_params
      params.require(:rating).permit!
    end
end

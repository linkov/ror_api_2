class Api::V1::RatebacksController < ApplicationController
  before_action :set_rateback, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /ratebacks
  def index

    if params[:user_id]
      ratings = Rating.where(:user_id => params[:user_id])
      feedbacks = Feedback.where(:rating_id => ratings.collect(&:id))
      @ratebacks = Rateback.where(:feedback_id => feedbacks.collect(&:id))
      render json: @ratebacks, each_serializer: RatebackscoreSerializer
    elsif params[:project_id]

      ratings = Rating.where(:project_id => params[:project_id])

      if params[:rater_id]
        ratings = Rating.where(:project_id => params[:project_id], :user_id => params[:rater_id])
      end

       feedbacks = Feedback.where(:rating_id => ratings.collect(&:id))
       @ratebacks = Rateback.where(:feedback_id => feedbacks.collect(&:id))
       render json: @ratebacks, each_serializer: RatebackscoreSerializer
    else

      @ratebacks = Rateback.all
      render json: @ratebacks
    end



  end

  # GET /ratebacks/1
  def show
    render json: @rateback
  end

  # POST /ratebacks
  def create
    @rateback = Rateback.new(rateback_params)

    if @rateback.save
    else
      render json: @rateback.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ratebacks/1
  def update
    if @rateback.update(rateback_params)
      render json: @rateback
    else
      render json: @rateback.errors, status: :unprocessable_entity
    end
  end

  # DELETE /ratebacks/1
  def destroy
    @rateback.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_rateback
      @rateback = Rateback.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def rateback_params
      params.require(:rateback).permit(:feedback_id, :value)
    end
end

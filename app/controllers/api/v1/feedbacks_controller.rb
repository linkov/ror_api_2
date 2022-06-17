class Api::V1::FeedbacksController < ApplicationController
  before_action :set_feedback, only: [:show, :update, :destroy]
  before_action :authenticate_user!, if: -> { !params[:project_id] }

  # GET /feedbacks
  def index


    if params[:project_id]

      project_ratings = Rating.where(:project_id => params[:project_id], :user_id => params[:rater_id])
      feedbacks = Feedback.where(:rating_id => project_ratings )


      if params[:closed_session]

      end
      # feedbacks = feedbacks.where.not(:id => Rateback.all.collect(&:feedback_id) )
      @feedbacks = feedbacks.order(:created_at).reverse()
      render json: @feedbacks, each_serializer: NewsfeedFeedbackSerializer

    elsif params[:rateback_value]
      project = Project.find(params[:p_id])
      feedbacks = Feedback.where(:rating_id =>project.ratings.collect(&:id), :id => Rateback.where(:value =>params[:rateback_value] ).collect(&:feedback_id) ).sort_by(&:created_at).reverse()
      @feedbacks = feedbacks
      render json: @feedbacks

    elsif params[:project_id_only]
      project_ratings = Rating.where(:project_id => params[:project_id_only])
      feedbacks = Feedback.where(:rating_id => project_ratings )
      # feedbacks = feedbacks.where.not(:id => Rateback.all.collect(&:feedback_id) )
      @feedbacks = feedbacks.order(:created_at).reverse()
      render json: @feedbacks

    else
      @feedbacks = Feedback.all.order(:created_at).reverse()
      render json: @feedbacks
    end





  end

  def delete_all_ratebacks
    project_ratings = Rating.where(:project_id => params[:project_id],:user_id => params[:rater_id] )
    feedbacks = Feedback.where(:rating_id => project_ratings.collect(&:id))
    ratebacks = Rateback.where(:feedback_id => feedbacks.collect(&:id))

    ratebacks.destroy_all
    render json: feedbacks
  end

  # GET /feedbacks/1
  def show
    render json: @feedback
  end

  # POST /feedbacks
  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      render json: @feedback, status: :created
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /feedbacks/1
  def update
    if @feedback.update(feedback_params)
      render json: @feedback
    else
      render json: @feedback.errors, status: :unprocessable_entity
    end
  end

  # DELETE /feedbacks/1
  def destroy
    @feedback.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def feedback_params
      params.require(:feedback).permit(:text, :drawing, :order, :type, :link, :rating_id, :avratingparam_id, :avtracktimeposition)
    end
end

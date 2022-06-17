class Api::V1::FeedbacksessionsController < ApplicationController
  before_action :set_feedbacksession, only: [:show, :update, :destroy]

  # GET /feedbacksessions
  def index
    @feedbacksessions = Feedbacksession.all

    render json: @feedbacksessions
  end

  # GET /feedbacksessions/1
  def show
    render json: @feedbacksession
  end
  
  def paidsessionpaid
    rating = Rating.where(:user_id => params[:raterID], :project_id => params[:projectID]).first
    if rating && rating.feedbacksession_id 
      feedbacksession =   Feedbacksession.find(rating.feedbacksession_id )
      feedbacksession.paid = true
      feedbacksession.save!
      render json: feedbacksession
    else
      render json: nil
    end
    
    
  end

  def paidsession
    rating = Rating.where(:user_id => params[:raterID], :project_id => params[:projectID]).first
    if rating && rating.feedbacksession_id 
      feedbacksession =   Feedbacksession.find(rating.feedbacksession_id )
      render json: feedbacksession
    else
      render json: nil
    end
    
    
  end

  # POST /feedbacksessions
  def create
    @feedbacksession = Feedbacksession.new(feedbacksession_params)

    if @feedbacksession.save
      render json: @feedbacksession, status: :created
    else
      render json: @feedbacksession.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /feedbacksessions/1
  def update
    if @feedbacksession.update(feedbacksession_params)
      render json: @feedbacksession
    else
      render json: @feedbacksession.errors, status: :unprocessable_entity
    end
  end

  # DELETE /feedbacksessions/1
  def destroy
    @feedbacksession.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedbacksession
      @feedbacksession = Feedbacksession.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def feedbacksession_params
      params.require(:feedbacksession).permit!
    end
end

class Api::V1::ReviewqueuesController < ApplicationController
  before_action :set_reviewqueue, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  def add_to_reviewqueue

    if params[:feedback_id]
      feedback = Feedback.find(params[:feedback_id])
      rating = Rating.find(feedback.rating_id)

      q =  Reviewqueue.new({
          :user_id => current_user.id,
          :project_id => rating.project_id
          })
      q.save!
    else
      q =  Reviewqueue.new({
          :user_id => current_user.id,
          :project_id => params[:project_id]
          })
      q.save!
    end


    render json: q
  end


  def remove_from_reviewqueue
    if params[:feedback_id]
      feedback = Feedback.find(params[:feedback_id])
      rating = Rating.find(feedback.rating_id)
      q = Reviewqueue.where(:user_id => current_user.id, :project_id =>rating.project_id).first
      q.destroy
    else

      q = Reviewqueue.where(:user_id => current_user.id, :project_id =>params[:project_id]).first
      q.destroy
    end


    render body: q, status: :no_content
  end

  # GET /reviewqueues
  def index
    @reviewqueues = Reviewqueue.all
    render json: @reviewqueues
  end

  # GET /reviewqueues/1
  def show
    render json: @reviewqueue
  end

  # POST /reviewqueues
  def create
    @reviewqueue = Reviewqueue.new(reviewqueue_params)

    if @reviewqueue.save
      render json: @reviewqueue, status: :created, location: @reviewqueue
    else
      render json: @reviewqueue.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /reviewqueues/1
  def update
    if @reviewqueue.update(reviewqueue_params)
      render json: @reviewqueue
    else
      render json: @reviewqueue.errors, status: :unprocessable_entity
    end
  end

  # DELETE /reviewqueues/1
  def destroy
    @reviewqueue.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_reviewqueue
      @reviewqueue = Reviewqueue.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def reviewqueue_params
      params.require(:reviewqueue).permit(:user_id, :project_id)
    end
end

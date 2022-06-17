class Api::V1::PresenterquestionanswersController < ApplicationController
  before_action :set_presenterquestionanswer, only: [:show, :update, :destroy]

  def presenterquestionanswersforrateflowproject


    presenterquestions = Presenterquestion.where(:project_id => params[:project_id])

    objs = Presenterquestionanswer.where(:user_id => params[:user_id], :presenterquestion_id => presenterquestions.collect(&:id))

    render json:objs

  end

  # GET /presenterquestionanswers
  def index

    if params[:userID]
    
      projects = Project.where(:user_id => params[:userID])
      questions = Presenterquestion.where(:project_id => projects.collect(&:id))
      @presenterquestionanswers = Presenterquestionanswer.where(:presenterquestion_id => questions.collect(&:id))
      render json: @presenterquestionanswers.order(:created_at).reverse(), each_serializer: PresenterquestionanswerStatsSerializer
    else
      @presenterquestionanswers = Presenterquestionanswer.all
      render json: @presenterquestionanswers
    end
    
    
  end

  # GET /presenterquestionanswers/1
  def show
    render json: @presenterquestionanswer
  end

  # POST /presenterquestionanswers
  def create
    @presenterquestionanswer = Presenterquestionanswer.new(presenterquestionanswer_params)

    if @presenterquestionanswer.save
      render json: @presenterquestionanswer, status: :created
    else
      render json: @presenterquestionanswer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /presenterquestionanswers/1
  def update
    if @presenterquestionanswer.update(presenterquestionanswer_params)
      render json: @presenterquestionanswer
    else
      render json: @presenterquestionanswer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /presenterquestionanswers/1
  def destroy
    @presenterquestionanswer.destroy
    render json: @presenterquestionanswer
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_presenterquestionanswer
      @presenterquestionanswer = Presenterquestionanswer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def presenterquestionanswer_params
      params.require(:presenterquestionanswer).permit!
    end
end

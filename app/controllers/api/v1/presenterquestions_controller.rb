class Api::V1::PresenterquestionsController < ApplicationController
  before_action :set_presenterquestion, only: [:show, :update, :destroy]

  # GET /presenterquestions
  def index
    @presenterquestions = Presenterquestion.all

    render json: @presenterquestions
  end

  # GET /presenterquestions/1
  def show
    render json: @presenterquestion
  end

  # POST /presenterquestions
  def create
    @presenterquestion = Presenterquestion.new(presenterquestion_params)

    if @presenterquestion.save
      render json: @presenterquestion, status: :created
    else
      render json: @presenterquestion.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /presenterquestions/1
  def update
    if @presenterquestion.update(presenterquestion_params)
      render json: @presenterquestion
    else
      render json: @presenterquestion.errors, status: :unprocessable_entity
    end
  end

  # DELETE /presenterquestions/1
  def destroy
    @presenterquestion.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_presenterquestion
      @presenterquestion = Presenterquestion.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def presenterquestion_params
      params.require(:presenterquestion).permit(:project_id, :title)
    end
end

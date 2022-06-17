class Api::V1::ProjectquestionanswersController < ApplicationController
  before_action :set_projectquestionanswer, only: [:show, :update, :destroy]

  # GET /projectquestionanswers
  def index
    @projectquestionanswers = Projectquestionanswer.all

    render json: @projectquestionanswers
  end

  # GET /projectquestionanswers/1
  def show
    render json: @projectquestionanswer
  end

  # POST /projectquestionanswers
  def create
    @projectquestionanswer = Projectquestionanswer.new(projectquestionanswer_params)

    if @projectquestionanswer.save
      render json: @projectquestionanswer, status: :created
    else
      render json: @projectquestionanswer.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projectquestionanswers/1
  def update
    if @projectquestionanswer.update(projectquestionanswer_params)
      render json: @projectquestionanswer
    else
      render json: @projectquestionanswer.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projectquestionanswers/1
  def destroy
    @projectquestionanswer.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projectquestionanswer
      @projectquestionanswer = Projectquestionanswer.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def projectquestionanswer_params
      params.require(:projectquestionanswer).permit(:project_id, :answer, :user_id)
    end
end

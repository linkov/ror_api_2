class Api::V1::AvfeedbacklanesController < ApplicationController
  before_action :set_avfeedbacklane, only: [:show, :update, :destroy]

  # GET /avfeedbacklanes
  def index
    if params[:ratingID]
      @avfeedbacklanes = Avfeedbacklane.where(:rating_id => params[:ratingID])
    else
      @avfeedbacklanes = Avfeedbacklane.all
    end


    render json: @avfeedbacklanes
  end

  # GET /avfeedbacklanes/1
  def show
    render json: @avfeedbacklane
  end

  # POST /avfeedbacklanes
  def create
    @avfeedbacklane = Avfeedbacklane.new(avfeedbacklane_params)

    if @avfeedbacklane.save
      render json: @avfeedbacklane, status: :created
    else
      render json: @avfeedbacklane.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /avfeedbacklanes/1
  def update
    if @avfeedbacklane.update(avfeedbacklane_params)
      render json: @avfeedbacklane
    else
      render json: @avfeedbacklane.errors, status: :unprocessable_entity
    end
  end

  # DELETE /avfeedbacklanes/1
  def destroy
    @avfeedbacklane.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avfeedbacklane
      @avfeedbacklane = Avfeedbacklane.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def avfeedbacklane_params
      params.require(:avfeedbacklane).permit(:rating_id, :avratingparam_id)
    end
end

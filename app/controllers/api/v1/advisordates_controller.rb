class Api::V1::AdvisordatesController < ApplicationController
  before_action :set_advisordate, only: [:show, :update, :destroy]

  # GET /advisordates
  def index
    @advisordates = Advisordate.all

    render json: @advisordates
  end

  # GET /advisordates/1
  def show
    render json: @advisordate
  end

  # POST /advisordates
  def create
    @advisordate = Advisordate.new(advisordate_params)

    if @advisordate.save
      render json: @advisordate, status: :created
    else
      render json: @advisordate.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /advisordates/1
  def update
    if @advisordate.update(advisordate_params)
      render json: @advisordate
    else
      render json: @advisordate.errors, status: :unprocessable_entity
    end
  end

  # DELETE /advisordates/1
  def destroy
    @advisordate.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_advisordate
      @advisordate = Advisordate.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def advisordate_params
      params.require(:advisordate).permit(:day, :time, :user_id)
    end
end

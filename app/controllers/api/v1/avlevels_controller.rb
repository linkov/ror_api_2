class Api::V1::AvlevelsController < ApplicationController
  before_action :set_avlevel, only: [:show, :update, :destroy]

  # GET /avlevels
  def index
    @avlevels = Avlevel.all

    render json: @avlevels
  end

  # GET /avlevels/1
  def show
    render json: @avlevel
  end

  # POST /avlevels
  def create
    @avlevel = Avlevel.new(avlevel_params)

    if @avlevel.save
      render json: @avlevel
    else
      render json: @avlevel.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /avlevels/1
  def update
    if @avlevel.update(avlevel_params)
      render json: @avlevel
    else
      render json: @avlevel.errors, status: :unprocessable_entity
    end
  end

  # DELETE /avlevels/1
  def destroy
    @avlevel.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_avlevel
      @avlevel = Avlevel.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def avlevel_params
      params.require(:avlevel).permit(:start, :end, :level, :feedback_id)
    end
end

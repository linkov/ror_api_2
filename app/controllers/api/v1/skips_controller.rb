class Api::V1::SkipsController < ApplicationController
  before_action :set_skip, only: [:show, :update, :destroy]

  # GET /skips
  def index
    @skips = Skip.all

    render json: @skips
  end

  # GET /skips/1
  def show
    render json: @skip
  end

  # POST /skips
  def create
    @skip = Skip.new(skip_params)

    if @skip.save
      render json: @skip, status: :created
    else
      render json: @skip.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /skips/1
  def update
    if @skip.update(skip_params)
      render json: @skip
    else
      render json: @skip.errors, status: :unprocessable_entity
    end
  end

  # DELETE /skips/1
  def destroy
    @skip.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skip
      @skip = Skip.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skip_params
      params.require(:skip).permit(:user_id, :skiptime, :project_id, :artcategory_id, :parentartcategory_id)
    end
end

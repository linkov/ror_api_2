class Api::V1::ArtrelationsController < ApplicationController
  before_action :set_artrelation, only: [:show, :update, :destroy]

  # GET /artrelations
  def index

    if params[:category_id]
      @artrelations = Artrelation.where(:fromcategory_id => params[:category_id])
      render json: @artrelations
    elsif params[:performance]
      @artrelations = Artrelation.where(:id => Rating.all.collect(&:categoryrelation_id))
      render json: @artrelations, each_serializer: AdminCategoryrelationSerializer
    else
      @artrelations = Artrelation.all
      render json: @artrelations

    end





  end

  # GET /artrelations/1
  def show
    render json: @artrelation
  end

  # POST /artrelations
  def create
    @artrelation = Artrelation.new(artrelation_params)

    if @artrelation.save
      render json: @artrelation, status: :created
    else
      render json: @artrelation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /artrelations/1
  def update
    if @artrelation.update(artrelation_params)
      render json: @artrelation
    else
      render json: @artrelation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /artrelations/1
  def destroy
    @artrelation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artrelation
      @artrelation = Artrelation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artrelation_params
      params.require(:artrelation).permit(:fromcategory_id, :tocategory_id, :weight)
    end
end

class Api::V1::CategoryrelationsController < ApplicationController
  before_action :set_categoryrelation, only: [:show, :update, :destroy]

  # GET /categoryrelations
  def index

    if params[:category_id]
      @categoryrelations = Categoryrelation.where("(categoryrelations.fromcategory_id = ? OR categoryrelations.tocategory_id =?)",params[:category_id],params[:category_id])
      render json: @categoryrelations
    elsif params[:parentcategory_id]
      @categoryrelations = Categoryrelation.where("(categoryrelations.fromparentcategory_id = ? OR categoryrelations.toparentcategory_id =?)",params[:parentcategory_id],params[:parentcategory_id])
      render json: @categoryrelations
    elsif params[:performance]
      @categoryrelations = Categoryrelation.where(:id => Rating.all.collect(&:categoryrelation_id))
      render json: @categoryrelations, each_serializer: AdminCategoryrelationSerializer
    else
      @categoryrelations = Categoryrelation.all
      render json: @categoryrelations
    end



  end

  # GET /categoryrelations/1
  def show
    render json: @categoryrelation
  end

  # POST /categoryrelations
  def create

    @categoryrelation = Categoryrelation.new(categoryrelation_params)



    if @categoryrelation.save
      render json: @categoryrelation, status: :created
    else
      render json: @categoryrelation.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /categoryrelations/1
  def update
    if @categoryrelation.update(categoryrelation_params)
      render json: @categoryrelation
    else
      render json: @categoryrelation.errors, status: :unprocessable_entity
    end
  end

  # DELETE /categoryrelations/1
  def destroy
    @categoryrelation.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_categoryrelation
      @categoryrelation = Categoryrelation.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def categoryrelation_params
      params.require(:categoryrelation).permit!
    end
end

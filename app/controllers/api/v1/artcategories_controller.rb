class Api::V1::ArtcategoriesController < ApplicationController
  before_action :set_artcategory, only: [:show, :update, :destroy]

  # GET /artcategories
  def index
    if params[:flat] || params[:bound_to_skill] || params[:is_active]
      @artcategories = Artcategory.where(filter_params)

      render json: @artcategories, each_serializer: ArtcategoryFlatSerializer
    else
      @artcategories = Artcategory.where(:parent_id => nil )

      render json: @artcategories
    end

  end

  # GET /artcategories/1
  def show
    render json: @artcategory
  end

  # POST /artcategories
  def create
    @artcategory = Artcategory.new(artcategory_params)
    @artcategory.parent = Artcategory.find(params[:id]) unless params[:id].nil?

    if @artcategory.save
      render json: @artcategory, status: :created
    else
      render json: @artcategory.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /artcategories/1
  def update
    if @artcategory.update(artcategory_params)
      render json: @artcategory
    else
      render json: @artcategory.errors, status: :unprocessable_entity
    end
  end

  def multi_update
    params[:artcategories].each do |ac|
      Artcategory.update(ac[:id], { order: ac[:order], bound_to_skill: ac[:bound_to_skill], is_active: ac[:is_active] })
    end

    render json: {}, head: :ok
  end

  # DELETE /artcategories/1
  def destroy
    @artcategory.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artcategory
      @artcategory = Artcategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artcategory_params
      params.require(:artcategory).permit(:name, :parent_id, :order, :bound_to_skill, :is_active)
    end

    def filter_params
      params.permit(:bound_to_skill, :is_active)
    end
end

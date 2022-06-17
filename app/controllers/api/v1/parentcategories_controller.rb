class Api::V1::ParentcategoriesController < ApplicationController
  before_action :set_parentcategory, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /parentcategories
  def index
    @parentcategories = Parentcategory.all

    render json: @parentcategories
  end

  # GET /parentcategories/1
  def show
    render json: @parentcategory
  end

  # POST /parentcategories
  def create
    @parentcategory = Parentcategory.new(parentcategory_params)

    if @parentcategory.save
      render json: @parentcategory, status: :created
    else
      render json: @parentcategory.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /parentcategories/1
  def update
    if @parentcategory.update(parentcategory_params)
      render json: @parentcategory
    else
      render json: @parentcategory.errors, status: :unprocessable_entity
    end
  end

  # DELETE /parentcategories/1
  def destroy
    @parentcategory.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_parentcategory
      @parentcategory = Parentcategory.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def parentcategory_params
      params.require(:parentcategory).permit!
    end

end

class Api::V1::ArttagsController < ApplicationController
  before_action :set_arttag, only: [:show, :update, :destroy]

  # GET /arttags
  def index
    @arttags = Arttag.all

    render json: @arttags
  end

  # GET /arttags/1
  def show
    render json: @arttag
  end

  # POST /arttags
  def create
    @arttag = Arttag.new(arttag_params)

    if @arttag.save
      render json: @arttag, status: :created, location: @arttag
    else
      render json: @arttag.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /arttags/1
  def update
    if @arttag.update(arttag_params)
      render json: @arttag
    else
      render json: @arttag.errors, status: :unprocessable_entity
    end
  end

  # DELETE /arttags/1
  def destroy
    @arttag.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arttag
      @arttag = Arttag.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def arttag_params
      params.require(:arttag).permit(:name)
    end
end

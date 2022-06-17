class Api::V1::ArttagfieldsController < ApplicationController
  before_action :set_arttagfield, only: [:show, :update, :destroy]

  # GET /arttagfields
  def index
    @arttagfields = Arttagfield.includes(:arttags)

    render json: @arttagfields
  end

  # GET /arttagfields/1
  def show
    render json: @arttagfield
  end

  # POST /arttagfields
  def create
    @arttagfield = Arttagfield.new(arttagfield_params)

    if @arttagfield.save
      render json: @arttagfield, status: :created, location: @arttagfield
    else
      render json: @arttagfield.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /arttagfields/1
  def update
    if @arttagfield.update(arttagfield_params)
      render json: @arttagfield
    else
      render json: @arttagfield.errors, status: :unprocessable_entity
    end
  end

  # DELETE /arttagfields/1
  def destroy
    @arttagfield.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_arttagfield
      @arttagfield = Arttagfield.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def arttagfield_params
      params.require(:arttagfield).permit(:name)
    end
end

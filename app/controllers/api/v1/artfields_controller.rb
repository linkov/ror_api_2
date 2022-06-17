class Api::V1::ArtfieldsController < ApplicationController
  before_action :set_artfield, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /artfields
  def index
    @artfields = Artfield.all

    render json: @artfields
  end

  # GET /artfields/1
  def show
    render json: @artfield
  end

  # POST /artfields
  def create
    @artfield = Artfield.new(artfield_params)

    if @artfield.save
      render json: @artfield, status: :created
    else
      render json: @artfield.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /artfields/1
  def update
    if @artfield.update(artfield_params)
      puts artfield_params
      # artfield_params['artfield']['parentcategories'].each do |k, v|
      #   cat = Category.find(v)
      #   @artfield.parentcategories << cat
      # end

      render json: @artfield
    else
      render json: @artfield.errors, status: :unprocessable_entity
    end
  end

  # DELETE /artfields/1
  def destroy
    @artfield.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artfield
      @artfield = Artfield.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artfield_params
      params.require(:artfield).permit!
    end
end

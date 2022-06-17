class Api::V1::MyadvisersController < ApplicationController
  before_action :set_myadviser, only: [:show, :update, :destroy]



  def removemyadviser
    myadviser = Myadviser.where(:user_id => myadviser_params[:user_id], :adviserid => myadviser_params[:adviserid]).first
    if myadviser != nil
      Projectadvisor.where(:myadviser_id => myadviser.id).delete_all
      myadviser.destroy
      render body: nil, status: :no_content
    else
      render :json => {:error => "not-found"}.to_json, :status => 404
    end

  end
  # GET /myadvisers
  def index
    @myadvisers = Myadviser.all

    render json: @myadvisers
  end

  # GET /myadvisers/1
  def show
    render json: @myadviser
  end

  # POST /myadvisers
  def create

    @myadviser = Myadviser.where(:user_id => myadviser_params[:user_id], :adviserid => myadviser_params[:adviserid]).first
    if @myadviser == nil
      @myadviser = Myadviser.new(myadviser_params)
      if @myadviser.save
        render json: @myadviser, status: :created
      else
        render json: @myadviser.errors, status: :unprocessable_entity
      end
    else
      render json: @myadviser, status: :created
    end


  end

  # PATCH/PUT /myadvisers/1
  def update
    if @myadviser.update(myadviser_params)
      render json: @myadviser
    else
      render json: @myadviser.errors, status: :unprocessable_entity
    end
  end

  # DELETE /myadvisers/1
  def destroy
    @myadviser.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_myadviser
      @myadviser = Myadviser.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def myadviser_params
      params.require(:myadviser).permit(:user_id, :adviserid)
    end
end

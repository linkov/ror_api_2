class Api::V1::TagfeedbacksController < ApplicationController
  before_action :set_tagfeedback, only: [:show, :update, :destroy]

  # GET /tagfeedbacks
  def index
    if params[:file_id]
      @tagfeedbacks = Tagfeedback.where(:projectfile_id => params[:file_id])
    else
      @tagfeedbacks = Tagfeedback.all
    end


    render json: @tagfeedbacks
  end

  # GET /tagfeedbacks/1
  def show
    render json: @tagfeedback
  end

  # POST /tagfeedbacks
  def create
    @tagfeedback = Tagfeedback.new(tagfeedback_params)

    if @tagfeedback.save
      render json: @tagfeedback
    else
      render json: @tagfeedback.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tagfeedbacks/1
  def update
    if @tagfeedback.update(tagfeedback_params)
      render json: @tagfeedback
    else
      render json: @tagfeedback.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tagfeedbacks/1
  def destroy
    @tagfeedback.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tagfeedback
      @tagfeedback = Tagfeedback.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def tagfeedback_params
      params.require(:tagfeedback).permit(:projectfile_id, :feedback_id, :arttag_id, :count)
    end
end

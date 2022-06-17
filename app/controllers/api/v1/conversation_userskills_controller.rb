class Api::V1::ConversationUserskillsController < ApplicationController
  before_action :set_conversation_userskill, only: [:show, :update, :destroy]

  # GET /conversation_userskills
  def index
    @conversation_userskills = ConversationUserskill.all

    render json: @conversation_userskills
  end

  # GET /conversation_userskills/1
  def show
    render json: @conversation_userskill
  end

  # POST /conversation_userskills
  def create
    @conversation_userskill = ConversationUserskill.new(conversation_userskill_params)

    if @conversation_userskill.save
      render json: @conversation_userskill, status: :created
    else
      render json: @conversation_userskill.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /conversation_userskills/1
  def update
    if @conversation_userskill.update(conversation_userskill_params)
      render json: @conversation_userskill
    else
      render json: @conversation_userskill.errors, status: :unprocessable_entity
    end
  end

  # DELETE /conversation_userskills/1
  def destroy
    @conversation_userskill.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_conversation_userskill
      @conversation_userskill = ConversationUserskill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def conversation_userskill_params
      params.require(:conversation_userskill).permit(:conversation_id, :user_skill_id,  :advisorrate)
    end
end

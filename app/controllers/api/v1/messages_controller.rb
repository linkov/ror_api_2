class Api::V1::MessagesController < ApplicationController
  before_action :set_message, only: [:show, :update, :destroy]
  before_action :authenticate_user!

  # GET /messages
  def index

    if params[:project_id]
        conversations = Conversation.where(:project_id => params[:project_id])
        @messages = Message.where(:conversation_id => conversations.collect(&:id))
    else
        @messages = Message.all
    end


    render json: @messages
  end

  # GET /messages/1
  def show
    render json: @message
  end

  # POST /messages
  def create
    @message = Message.new(message_params)
    @message.read = false

    if @message.save
      UnreadSendEmailJob.set(wait: 5.minutes).perform_later(@message)

      room = 'room_' + @message.conversation.user_recipient(current_user)
      data = get_message_data(@message)
      MessageChannel.broadcast(room, data)

      render json: @message, status: :created
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /messages/1
  def update
    return render json: @message if message_params[:read] && @message.user_id == current_user.id

    if @message.update(message_params)
      @message.updated = true

      data = get_message_data(@message)
      MessageChannel.broadcast("room_#{@message.user_id}", data)

      render json: @message
    else
      render json: @message.errors, status: :unprocessable_entity
    end
  end

  # DELETE /messages/1
  def destroy
    @message.destroy
  end

  private

    def get_message_data(message)
      message.attributes.slice('id', 'conversation_id', 'user_id', 'updated')
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_message
      @message = Message.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def message_params
      params.fetch(:message, {})
    end

    def message_params
      params.require(:message).permit(:body, :user_id, :conversation_id, :read, :paymentrequestamount,
                                      :paymentrequestapproved, :paymentrequesttime, :paymentrequestdenied, :special)
    end
end

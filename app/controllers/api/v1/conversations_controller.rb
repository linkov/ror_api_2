class Api::V1::ConversationsController < ApplicationController
  serialization_scope :view_context
  before_action :authenticate_user!


  def show
    conversation = Conversation.find(params[:id])

    return render status: :forbidden unless conversation.user_in_conversation?(current_user)
    # conversation.messages.each do | message|
    #   message.read = true
    #   message.save!
    # end
    render json: conversation
  end

  # PATCH/PUT /feedbacks/1
  def update
    @conversation = Conversation.find(params[:id])
    if @conversation.update(conversation_params)
      render json: @conversation
    else
      render json: @conversation.errors, status: :unprocessable_entity
    end
  end

  def index

    if params[:project_id] && !params[:rater_id]
      @conversations = Conversation.where(:project_id => params[:project_id])

    elsif params[:project_id] && params[:rater_id]
      @conversations = Conversation.where(:project_id => params[:project_id])
      @conversations = @conversations.where('recipient_id=? OR sender_id=?', params[:rater_id], params[:rater_id])
      if @conversations.first
        render json:@conversations.first, serializer: ConversationSerializer, :root => 'conversation'
      else
        render json:{}
      end

    else
      @conversations = Conversation.where('recipient_id=? OR sender_id=?', current_user.id, current_user.id)
      render json:@conversations ? @conversations : []
    end


  end

  def create
    conversations = Conversation.where("(conversations.sender_id = ? AND conversations.recipient_id =?) OR (conversations.sender_id = ? AND conversations.recipient_id =?)", conversation_params[:sender_id],conversation_params[:recipient_id], conversation_params[:recipient_id],conversation_params[:sender_id])
    project_conversation = conversations.where(:project_id => conversation_params[:project_id]).first
    if project_conversation
      @conversation = project_conversation
    else
      work = Project.find_by_id(conversation_params[:project_id]) #returns nil and not an exception

      @conversation = Conversation.create!({ meetingfinished: conversation_params[:meetingfinished],
                                            meetingconfirmed: conversation_params[:meetingconfirmed],
                                            isclarification: conversation_params[:isclarification],
                                            project: work, recipient_id: conversation_params[:recipient_id],
                                            sender_id: conversation_params[:sender_id],
                                            meetingtime: conversation_params[:meetingtime] })

      if  params[:user_skills]
        params[:user_skills].each do |user_skill|
          ConversationUserskill.create!({

            user_skill_id: user_skill[:id],
            conversation_id: @conversation.id

          })
        end

      end

    end

    render json:@conversation
    # redirect_to conversation_messages_path(@conversation)
  end
  private
  def conversation_params
    marking_keys = Set.new
    if params[:conversation][:user_skills]
      params[:conversation][:user_skills].keys.collect {|ii| marking_keys.add(ii)}
      params.require(:conversation).permit(:meetingfinished, :advisorrate, :meetingconfirmed, :meetingtime, :isclarification, :projectfile_id, :recipient_id, :sender_id, :project_id, user_skills: marking_keys.to_a)
    else
      params.require(:conversation).permit(:meetingfinished, :advisorrate, :meetingconfirmed, :meetingtime, :isclarification, :projectfile_id, :recipient_id, :sender_id, :project_id, user_skills: [])
    end

    #params.permit(params.keys).to_h
  end
end



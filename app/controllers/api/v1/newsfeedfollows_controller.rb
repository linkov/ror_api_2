class Api::V1::NewsfeedfollowsController < ApplicationController
  before_action :set_newsfeedfollow, only: [:show, :update, :destroy]


  def removenewsfeedfollow
    @newsfeedfollow = Newsfeedfollow.where(:artist_id => newsfeedfollow_params[:artist_id], :user_id => current_user.id).first

    if @newsfeedfollow
      @newsfeedfollow.delete
    end

  end

  def addnewsfeedfollow

      @newsfeedfollow =  Newsfeedfollow.new({
        :user_id => current_user.id,
        :artist_id => newsfeedfollow_params[:artist_id],
        :project_id => newsfeedfollow_params[:project_id],
        })

      @newsfeedfollow.save!
      render json: @newsfeedfollows

  end


  def submit_ideas

    MandrillUserMailer.sendIdeasFeedback(params[:email], params[:text], opts={}).deliver_now
    render json: [], status: :created

  end

  def submit_support
    MandrillUserMailer.sendSupportFeedback(params[:email], params[:text], opts={}).deliver_now
    render json: [], status: :created
  end

  # GET /newsfeedfollows
  def index
    if current_user
      @newsfeedfollows = Newsfeedfollow.where(:user_id => current_user.id )
    else
      @newsfeedfollows = [];
    end


    render json: @newsfeedfollows
  end

  # GET /newsfeedfollows/1
  def show
    render json: @newsfeedfollow
  end

  # POST /newsfeedfollows
  def create
    @newsfeedfollow = Newsfeedfollow.new(newsfeedfollow_params)

    if @newsfeedfollow.save
      render json: @newsfeedfollow, status: :created
    else
      render json: @newsfeedfollow.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /newsfeedfollows/1
  def update
    if @newsfeedfollow.update(newsfeedfollow_params)
      render json: @newsfeedfollow
    else
      render json: @newsfeedfollow.errors, status: :unprocessable_entity
    end
  end

  # DELETE /newsfeedfollows/1
  def destroy
    @newsfeedfollow.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_newsfeedfollow
      @newsfeedfollow = Newsfeedfollow.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def newsfeedfollow_params
      params.require(:newsfeedfollow).permit(:user_id, :artist_id, :commenter_id, :project_id)
    end
end

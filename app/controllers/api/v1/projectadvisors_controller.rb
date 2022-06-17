class Api::V1::ProjectadvisorsController < ApplicationController
  before_action :set_projectadvisor, only: [:show, :update, :destroy]

  # GET /projectadvisors
  def index
    @projectadvisors = Projectadvisor.all

    render json: @projectadvisors
  end

  # GET /projectadvisors/1
  def show
    render json: @projectadvisor
  end

  # POST /projectadvisors
  def create

    myadviser = Myadviser.where(:adviserid => projectadvisor_params[:myadviser_id]).first
    projectadvisor_params[:myadviser_id] = myadviser.id
    @projectadvisor = Projectadvisor.new(projectadvisor_params)
    @projectadvisor.myadviser_id = myadviser.id
    if @projectadvisor.save

      @project = Project.find(projectadvisor_params[:project_id])
      @projectadvisor.invitesent = true
      @projectadvisor.save!

      category_name = ""

      if @project.parentcategory_id
        category = Parentcategory.find(@project.parentcategory_id)
        category_name = category.name
      elsif @project.category_id
        category = Category.find(@project.category_id)
        category_name =  category.name
      end

      invite_advisor_user = User.find(myadviser.adviserid)
      invite_email = invite_advisor_user.email

      invite = Invite.create(:project_id => @project.id, :email => invite_email, :sent => true )
      invite.save!

      MandrillUserMailer.feedback_invite_advisor(category_name, @project, current_user.name,  invite_email, opts={}).deliver_now

      render json: @projectadvisor, status: :created
    else
      render json: @projectadvisor.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projectadvisors/1
  def update
    if @projectadvisor.update(projectadvisor_params)
      render json: @projectadvisor
    else
      render json: @projectadvisor.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projectadvisors/1
  def destroy
    @projectadvisor.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projectadvisor
      @projectadvisor = Projectadvisor.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def projectadvisor_params
      params.require(:projectadvisor).permit(:project_id, :myadviser_id, :invitesent)
    end
end

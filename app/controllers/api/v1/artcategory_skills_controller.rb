class Api::V1::ArtcategorySkillsController < ApplicationController
  before_action :set_artcategory_skill, only: [:show, :update, :destroy]

  # GET /artcategory_skills
  def index
    @artcategory_skills = ArtcategorySkill.all

    render json: @artcategory_skills
  end

  # GET /artcategory_skills/1
  def show
    render json: @artcategory_skill
  end

  # POST /artcategory_skills
  def create
    @artcategory_skill = ArtcategorySkill.new(artcategory_skill_params)

    if @artcategory_skill.save
      render json: @artcategory_skill, status: :created
    else
      render json: @artcategory_skill.errors, status: :unprocessable_entity
    end
  end

  def update
    @artcategory_skill.update!(artcategory_skill_order_params)
  end

  def destroy
    @artcategory_skill.destroy!
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_artcategory_skill
      @artcategory_skill = ArtcategorySkill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def artcategory_skill_params
      params.require(:artcategory_skill).permit(:artcategory_id, :skill_id)
    end

    def artcategory_skill_order_params
      params.require(:artcategory_skill).permit(:order)
    end
end

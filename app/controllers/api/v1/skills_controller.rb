class Api::V1::SkillsController < ApplicationController
  before_action :set_skill, only: [:show, :update, :destroy]

  # GET /skills
  def index
    @skills = Skill.includes([:user_skills, artcategory_skills: [:artcategory]])

    render json: @skills
  end

  # GET /skills/1
  def show
    render json: @skill
  end

  # POST /skills
  def create
    @skill = Skill.new(skill_params)

    if @skill.save
      render json: @skill, status: :created
    else
      render json: @skill.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /skills/1
  def update
    if @skill.update(skill_params)
      render json: @skill
    else
      render json: @skill.errors, status: :unprocessable_entity
    end
  end

  # DELETE /skills/1
  def destroy
    @skill.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_skill
      @skill = Skill.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def skill_params
      params.require(:skill).permit(:shortname, :name, :icon, :link,
                                    artcategory_skills_attributes: %i[id _destroy skill_id artcategory_id order])
    end
end

class Api::V1::ProjectfilesController < ApplicationController
  before_action :set_projectfile, only: [:show, :update, :destroy]
  before_action :authenticate_user!, if: -> { !params[:newsfeed_request] }

  # GET /projectfiles
  def index


    if params[:feedback_id]
      feedback = Feedback.find(params[:feedback_id])
      rating = Rating.where(:id => feedback.rating_id).first
      if rating.ratingtype == 'project'
        @files = Projectfile.where(:project_id => rating.project_id)

      elsif rating.ratingtype == 'files'
        @files = Projectfile.where(:id => rating.projectfile_id)
      elsif rating.ratingtype == 'info'
        @files = [{
          project_id:rating.project_id,
          name:'projectinfo',
          handle: 'projectinfo',
          mimetype: 'projectinfo',
          kind: 'projectinfo'
          }]
      end

      render json: @files
    else
      @projectfiles = Projectfile.all
      render json: @projectfiles
    end


  end

  # GET /projectfiles/1
  def show
    render json: @projectfile
  end

  # POST /projectfiles
  def create
    @projectfile = Projectfile.new(projectfile_params)

    if @projectfile.save
      render json: @projectfile, status: :created
    else
      render json: @projectfile.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projectfiles/1
  def update
    if @projectfile.update(projectfile_params)
      render json: @projectfile
    else
      render json: @projectfile.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projectfiles/1
  def destroy
    @projectfile.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projectfile
      @projectfile = Projectfile.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def projectfile_params
      params.require(:projectfile).permit(:filedescription, :showinfo, :likecount, :order, :name, :width, :height, :mimetype, :project_id, :handle, :url)
    end
end

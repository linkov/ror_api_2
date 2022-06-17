class Api::V1::ProjectresortsController < ApplicationController
  before_action :set_projectresort, only: [:show, :update, :destroy]

  # # GET /projectresorts
  # api :GET, '/projectresorts', "Get resorts"
  # api :GET, '/projectresorts/?=project_id&rater_id', "Get resorts for project & rater"
  def index
    if params[:project_id] && params[:rater_id]
          @projectresorts = Projectresort.where(:project_id => params[:project_id],:user => params[:rater_id])
    else
          @projectresorts = Projectresort.all
    end
    render json: @projectresorts
  end

  # GET /projectresorts/1
  def show
    render json: @projectresort
  end

  # # POST /projectresorts
  # api :POST, '/projectresorts', "Create a resort"
  # param :projectresort, Hash, :desc => "" do
  #   param :user_id, Integer, :desc => "id of the rater", :required => true
  #   param :project_id, Integer, :desc => "id of the project", :required => true
  #   param :comment, String, :desc => "comment about the resort"
  #   param :resortimages, Hash, :desc => "Images that were resorted", :required => true do
  #     property :projectfile_id, Integer
  #     property :order, Integer
  #   end
  # end

  def create
    @projectresort = Projectresort.new(projectresort_params)

    if @projectresort.save
      render json: @projectresort, status: :created
    else
      render json: @projectresort.errors, status: :unprocessable_entity
    end
  end

  # # PATCH/PUT /projectresorts/1
  # api :PUT, '/projectresorts/:id', "Update a resort"
  # param :projectresort, Hash, :desc => "" do
  #   param :user_id, Integer, :desc => "id of the rater", :required => true
  #   param :project_id, Integer, :desc => "id of the project", :required => true
  #   param :comment, String, :desc => "comment about the resort"
  #   param :resortimages, Hash, :desc => "Images that were resorted", :required => true do
  #     property :projectfile_id, Integer
  #     property :order, Integer
  #   end
  # end
  def update
    if @projectresort.update(projectresort_params)
      render json: @projectresort
    else
      render json: @projectresort.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projectresorts/1
  api :DELETE, '/projectresorts/:id', "Delete a resort"
  def destroy
    @projectresort.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_projectresort
      @projectresort = Projectresort.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def projectresort_params
      params.require(:projectresort).permit(:user_id, :project_id, :comment, resortimages_attributes: [:order,:projectfile_id])
    end
end

class Api::V1::NewsfeedController < ApplicationController


  def feedbacks_inspiring
    ratings = Rating.where(:user_id =>params[:userID] )

    fb = Feedback.where(:rating => ratings).order(:created_at).reverse()
    ratebacks = Rateback.where(:feedback_id => fb.collect(&:id), :value => 5)
    fb = Feedback.where(:id => ratebacks.collect(&:feedback_id))

    render json: fb, each_serializer: NewsfeedFeedbackSerializer

  end


  def my_pq_collections




  end

  # GET /feedbacks
  def feedbacks
    projectID = params[:projectID]
    mediatypes = params[:mediatypes]

    if projectID
        project = Project.find(projectID)
        ratings = Rating.where(:project_id => project.id )
        @feedbacks = Feedback.where(:rating => ratings).order(:created_at).reverse()
        render json: @feedbacks, each_serializer: NewsfeedFeedbackSerializer
    elsif mediatypes

      if mediatypes.size == 0
        mediatypes = "none"
      end

      # projectfiles = Projectfile.where("mimetype REGEXP ?", mediatypes)
      # ratings = Rating.where(:projectfile_id => projectfiles.collect(&:id) ).where.not(:ratingtype => "project" )
      #
      # @feedbacks = Feedback.where(:rating => ratings).order(:created_at).reverse()

      @feedbacks = Feedback.includes([:ratebacks, :avratingparam, rating: [:user, :feedbacksession, project: [:artcategory]]])
                           .joins(rating: :projectfile)
                           .joins('LEFT JOIN (SELECT value, feedback_id FROM ratebacks LIMIT 1) r ON r.feedback_id = feedbacks.id')
                           .where("projectfiles.mimetype REGEXP ?", mediatypes)
                           .where.not('ratings.ratingtype' => project)
                           .order("ratebacks.value desc")

      render json: @feedbacks, each_serializer: NewsfeedFeedbackSerializer
      else
        ratings = Rating.where.not(:ratingtype => "project" )
        @feedbacks = Feedback.where(:rating => ratings).order(:created_at).reverse()
        render json: @feedbacks, each_serializer: NewsfeedFeedbackSerializer
    end
  end

  # GET /feedbacks/1
  def show
    render json: @feedback
  end


  def media_url

    feedbackID = params[:feedbackID]
    feedback = Feedback.find(feedbackID)
    rating = Rating.where(:id => feedback.rating_id).first
    if rating.projectfile_id
      projectfiles = Projectfile.where(:id => rating.projectfile_id )
    else
      projectfiles = Projectfile.where(:project_id => rating.project_id )
    end

    render json: projectfiles.includes(:avconversion), each_serializer: SimpleProjectfileSerializer
  end

  def answer_create
    # @feedback = Feedback.new(feedback_params)
    #
    # if @feedback.save
    #   render json: @feedback, status: :created
    # else
    #   render json: @feedback.errors, status: :unprocessable_entity
    # end
  end

  # PATCH/PUT /feedbacks/1
  def answer_update
    # if @feedback.update(feedback_params)
    #   render json: @feedback
    # else
    #   render json: @feedback.errors, status: :unprocessable_entity
    # end
  end


end

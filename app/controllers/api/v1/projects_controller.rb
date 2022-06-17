class Api::V1::ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :update, :destroy], if: -> { !params[:feedback_id] }
  before_action :authenticate_user!, if: -> { !params[:userID] && (!params[:feedback_id] && !params[:projectfileID] && !params[:getpaidguest]) }, :except => [:show]

  def adviserprojects
    ratings = Rating.where(:user_id => params[:adviserID])
    project_ids = Project.where(:id => ratings.collect(&:project_id), :user_id => current_user.id).pluck("DISTINCT id")
    render json: Project.where(:id => project_ids), each_serializer: SimpleprojectSerializer, scope: {}
  end

  def studentprojects

    ratings = Rating.where(:user_id => current_user.id)
    project_ids = Project.where(:id => ratings.collect(&:project_id), :user_id => params[:studentID]).pluck("DISTINCT id")
    render json: Project.where(:id => project_ids), each_serializer: SimpleprojectSerializer, scope: {}
  end

  def publicproject
    project = Project.where(:sharetoken => params[:id]).first
    render json: project, serializer: NextProjectSerializer, scope: {}
  end

  def publicprojects
    projects = Project.includes(:ratings, :artcategory).where(:private => false, :user_id => params[:userID]).where.not(:sharetoken => nil)

    render json: projects, each_serializer: NextProjectSerializer, scope: {}
  end

  def projectsadmin
    @projects = Project.all
    render json: @projects.order(:created_at).reverse(), each_serializer: AdminProjectSerializer
  end


  def update_rateback
    rateback = Rateback.where(:feedback_id =>params[:feedback_id]).first

    return render json: rateback if current_user == rateback.try(:feedback).try(:user)

    if rateback
      rateback.value = params[:new_value];
      rateback.save!
    else
      newRateback = Rateback.new({
        :feedback_id => params[:feedback_id],
        :value => params[:new_value]
        })
      newRateback.save!

    end

    render json: rateback
  end



  def filetagclouds
    files = Projectfile.where(:project_id =>params[:projectID])
    tagsForfiles = Tagfeedback.where(:projectfile_id => files.collect(&:id)).where("count > :mincount", mincount: 2)
    files = files.where(:id => tagsForfiles.collect(&:projectfile_id))
    render json: files.order(:created_at).reverse(), each_serializer: ProjectfileSerializer
  end

  def presenter_questions
    if params[:projectID]
      @questions = Presenterquestion.where(:project_id => params[:projectID])
    else
      @questions = Presenterquestion.all()
    end

    render json: @questions.includes(:project).order(:created_at).reverse(), each_serializer: PresenterquestionNewsfeedSerializer
  end

  def presenter_projects
    if params[:projectID]
      @projects = Project.where.not(:presenterquestion => nil).where(:id => params[:projectID])
      render json: @projects.order(:created_at).reverse(), each_serializer: ProjectSerializer
    else
      @projects = Project.where.not(:presenterquestion => nil)
      render json: @projects.order(:created_at).reverse(), each_serializer: ProjectSerializer
    end


  end


  def my_choosethebest_projects
    if params[:projectID]
      projectFiles = Projectfile.where(:project_id => params[:projectID]).where("likecount > :mincount", mincount: 2)
      @projects = Project.where(:choosethebest => true).where(:id => projectFiles.collect(&:project_id))
      render json: @projects.order(:created_at).reverse(), each_serializer: ChoosethebestProjectSerializer
    else
      if current_user
        @projects = Project.where(:choosethebest => true, :user_id => current_user.id)
      else
        @projects = Project.where(:choosethebest => true)
      end

      render json: @projects.order(:created_at).reverse(), each_serializer: ChoosethebestProjectSerializer
    end


  end

  def choosethebest_projects
    if params[:projectID]
      projectFiles = Projectfile.where(:project_id => params[:projectID]).where("likecount > :mincount", mincount: 2)
      @projects = Project.where(:choosethebest => true).where(:id => projectFiles.collect(&:project_id))
      render json: @projects.order(:created_at).reverse(), each_serializer: ChoosethebestProjectSerializer
    else
      if current_user
        @projects = Project.where(:choosethebest => true).where.not(:user_id => current_user.id)
      else
        @projects = Project.where(:choosethebest => true)
      end

      render json: @projects.order(:created_at).includes([:artcategory, projectfiles: [:ratings, :avconversion]])
                            .reverse(), each_serializer: ChoosethebestProjectSerializer
    end


  end

  def projectsfeedback

  end

  # GET /projects
  def index
    if params[:getpaid] || params[:getpaidguest]
      if current_user
        current_user_ratings = Rating.where(:user_id => current_user.id)
        clarifying_conversations = Conversation.where(:isclarification => true)
        projects = Project.where('title LIKE ?', "%#{params[:q]}%").where.not(:inspiringrate => 0, :user_id => current_user.id, :id => current_user_ratings.collect(&:project_id)).where.not(:id => clarifying_conversations.collect(&:project_id))
      else
        projects = Project.where('title LIKE ?', "%#{params[:q]}%").where.not(:inspiringrate => 0)
      end

      render json: projects.includes(:ratings, :artcategory, :avratingparams, :user, :projectfiles),
             each_serializer: GetpaidProjectSerializer, scope: {}
    elsif params[:projectfileID]
      projectfile = Projectfile.find(params[:projectfileID])
      projects = Project.where(:id => projectfile.project_id)
      render json: projects, each_serializer: NextProjectSerializer, scope: {}
    elsif params[:reviewqueue]
      project_ids = Reviewqueue.where(user_id: current_user).pluck(:project_id)
      projects = Project.where(id: project_ids)

      render json: projects
    elsif params[:ctb]
      @projects = Project.where(:choosethebest => true)
      render json: @projects, each_serializer: NextProjectSerializer, scope: {}
    elsif params[:next]

      # BASIC
      userSkips = Skip.where(:user_id => current_user.id,created_at: 24.hours.ago..Time.now)
      currentUserRatings = Rating.where(:user_id => current_user.id)
      next_projects = Project.where.not(:private => true, :id => currentUserRatings.collect(&:project_id),:user_id => current_user.id).order("RAND()").where.not(:id => userSkips.collect(&:project_id))



      category_ids = userSkips.collect(&:artcategory_id).reject(&:blank?)
      parentcategory_ids = userSkips.collect(&:parentartcategory_id).reject(&:blank?)


      if category_ids.count > 0

        next_projects = next_projects.where.not(:artcategory_id => category_ids)

      end

      if parentcategory_ids.count > 0

        cats_to_exclude = []
        parent_categories = Artcategory.where(:id => parentcategory_ids)
        parent_categories.each do |parentcat|
            cats_to_exclude << parentcat
            parentcat.subcategories.each do |subcat|
              cats_to_exclude << subcat
            end
        end

        next_projects = next_projects.where.not(:artcategory_id => cats_to_exclude.collect(&:id))


      end


      #REVIEW QUEUE

      last_queued = Reviewqueue.where(:user_id => current_user.id).last
      if last_queued
          next_project_by_queued = next_projects.where(:id => last_queued.project_id).first
          if next_project_by_queued
            @next_project = next_project_by_queued
          else

            project_and_relation = nil

            last_invite_of_user = Invite.where(:email => current_user.email).last
            if last_invite_of_user
              next_project_by_invite = next_projects.where(:id => last_invite_of_user.project_id).first
              if next_project_by_invite
                @next_project = next_project_by_invite
              else

              project_and_relation =  perform_next_work_match(next_projects)


              end
            else


            project_and_relation =  perform_next_work_match(next_projects)


            end

          end
      else

        project_and_relation = nil

        last_invite_of_user = Invite.where(:email => current_user.email).last
        if last_invite_of_user
          next_project_by_invite = next_projects.where(:id => last_invite_of_user.project_id).first
          if next_project_by_invite
            @next_project = next_project_by_invite
          else

          project_and_relation =  perform_next_work_match(next_projects)


          end
        else


        project_and_relation =  perform_next_work_match(next_projects)


        end

      end










      if @next_project
        render json: @next_project, serializer: NextProjectSerializer, :root => 'project'
      elsif project_and_relation && project_and_relation[:project]
        render json: project_and_relation[:project], serializer: NextProjectSerializer, :root => 'project', scope: {relation: project_and_relation[:relation]}

      else
        render json: nil
      end

    elsif params[:rater_id]
      ratings = Rating.where(:user_id => params[:rater_id])
      @projects = Project.where(:id => ratings.collect(&:project_id))
      render json: @projects, each_serializer: NextProjectSerializer
    else

      @projects = Project.where(:user_id => current_user.id)
      render json: @projects, each_serializer: NextProjectSerializer
    end

  end

  def perform_next_work_match(next_projects)

    #CATEGORY RELATIONS

      if Setting.where(:name => 'enable_category_relations').first.value > 0



        user_projects = current_user.projects
        current_user_projects_categories = Artcategory.where(:id => user_projects.collect(&:artcategory_id))

        puts "current_user_projects_categories"
        puts current_user_projects_categories.collect(&:id)

        user_projects_category_relations = Artrelation.where(:fromcategory_id => current_user_projects_categories.collect(&:id)).or( Artrelation.where(:tocategory_id => current_user_projects_categories.collect(&:id)) ).order(:weight).reverse()

        puts "user_projects_category_relations"
        puts user_projects_category_relations

        user_projects_category_related_projects = []

        user_projects_category_relations.each do |relation|
          projects_to_add = next_projects.where(:artcategory_id => relation.tocategory_id).or( next_projects.where(:artcategory_id => relation.fromcategory_id) )
          if projects_to_add.count > 0
            user_projects_category_related_projects << {projects: projects_to_add, relation: relation}
          end

        end

        if user_projects_category_related_projects.count > 0
          puts "user_projects_category_related_projects FOUND"
          puts user_projects_category_related_projects[0]

          return {project:user_projects_category_related_projects[0][:projects].first, relation: user_projects_category_related_projects[0][:relation]}

        else
          @next_project = next_projects.first

        end


      else

        @next_project = next_projects.first

      end




  end

  # GET /projects/1
  def show

    if params[:feedback_id]
      feedback = Feedback.find(params[:feedback_id])
      puts "FEEDBACK>"
      puts feedback.id
      rating = Rating.find(feedback.rating_id)
      puts "rating>"
      puts rating.id

      project = Project.find(rating.project_id)
      puts "Project>"
      puts project.id
      render json: project
    else
      render json: @project
    end




  end

  # POST /projects
  def create
    @project = Project.new(project_params)



    if @project.save
      @project.sharetoken = SecureRandom.hex(5)
      @project.save!



      if @project.invites.count > 0

        @project.invites.each do |invite|
          invite.sent = true
          invite.save!

          category_name = ""

          if @project.parentcategory_id
            category = Parentcategory.find(@project.parentcategory_id)
            category_name = category.name
          elsif @project.category_id
            category = Category.find(@project.category_id)
            category_name =  category.name
          end
          MandrillUserMailer.feedback_invite(category_name, invite.id, invite.message, @project, invite.name, invite.email, opts={}).deliver_now
        end

      end

      render json: @project, status: :created
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /projects/1
  def update
    if @project.update(project_params)
      if @project.save

        if @project.invites.count > 0

          @project.invites.each do |invite|

            if invite.sent != true

              invite.sent = true
              invite.save!

              category_name = ""

              if @project.parentcategory_id
                category = Parentcategory.find(@project.parentcategory_id)
                category_name = category.name
              elsif @project.category_id
                category = Category.find(@project.category_id)
                category_name =  category.name
              end
              MandrillUserMailer.feedback_invite(category_name, invite.id, invite.message, @project, invite.name, invite.email, opts={}).deliver_now

            end


          end
        end
        end
      render json: @project
    else
      render json: @project.errors, status: :unprocessable_entity
    end
  end

  # DELETE /projects/1
  def destroy
    @project.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_project
      @project = Project.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def project_params
      params.require(:project).permit(
        :choosethebest,
        :presenterquestion,
        :inspiringrate,
        :feedback_id,
        :private,
        :purpose,
        :preview,
        :title,
        :description,
        :user_id,
        :artcategory_id,
        :parentcategory_id,
        :category_id,
        :show_payment_promise_to_anon,
        avratingparams_attributes: [:name, :color, :id],
        invites_attributes: [:name, :message, :email],
        presenterquestions_attributes: [:title, :id, :_destroy],
        projectfiles_attributes: [:id, :showinfo, :filedescription, :name,:handle,:mimetype,:url, :conversionjobid, :height, :width, :order]
      )
    end
end

class Api::V1::UsersController < ApplicationController
  before_action :set_user, only: [:show, :update, :destroy]

  def testEmail
    lesson_conversation = Conversation.find(29)
    teacher  = User.find(lesson_conversation.recipient_id)
    student =  User.find(lesson_conversation.sender_id)

    MandrillUserMailer.sendVideoLessonScheduledEmail(false, teacher, student, lesson_conversation, opts={}).deliver_later
    # MandrillUserMailer.sendVideoLessonScheduledEmail(true,teacher, student, lesson_conversation, opts={}).deliver_later(wait_until: lesson_conversation.meetingtime.prev_day(1))
    render json: [], status: :created

  end

  def show
    render json: @user
  end

  def userByEmail
    email = params[:email]
    user = User.where(:email => email).first
    render json: user, serializer: UserAdvisorSerializer
  end

  def advisors
    user_skills = UserSkill.all
    users_with_advisor_skills = User.includes([:advisordates, :myadvisers, :projects, :ratings, user_skills: [conversations: :lessons]])
                                    .where(:id => user_skills.collect(&:user_id))
                                    .order(online: :desc)

    render json: users_with_advisor_skills, each_serializer: UserAdvisorSerializer
  end

  def funnelforadvisor
    res = 0

    n_ratings_for_advisor = Rating.joins(:project)
                                  .where('projects.user_id' => current_user.id, 'ratings.user_id' => params[:advisorID])
                                  .pluck("DISTINCT project_id").count

    if Rateback.pr_counter(params[:advisorID], current_user.id).zero?
      res = 1

      return render json: res
    end

    if n_ratings_for_advisor < 5
      res = 2
    end

    if n_ratings_for_advisor >= 5
      res = 3
    end

    render json: res
  end

  def funnelforstudent

    res = 0

    all_ratings_from_user = Rating.where(:user_id => current_user.id)
    all_rated_projects = Project.where(:id => all_ratings_from_user.collect(&:project_id))
    rated_projects_of_student = all_rated_projects.where(:user_id => params[:studentID])
    n_ratings_of_student = Rating.where(:project_id => rated_projects_of_student.collect(&:id)).pluck("DISTINCT project_id").count
    if n_ratings_of_student < 2
      res = 1
    end

    if n_ratings_of_student >= 2 &&  n_ratings_of_student < 5
      res = 2
    end

    if n_ratings_of_student >= 5
      res = 3
    end

    render json: res

  end

  def funnels
    all_user_projects_ratings = Rating.joins(:project).where('projects.user_id' => current_user.id)
    all_advisors_for_this_user = User.joins(:ratings).where('ratings.project_id' => current_user.projects.ids).where.not('users.id' => current_user.id).distinct

    first_time_advisor_count = 0
    interested_advisors_count = 0
    regular_advisors_count = 0

    all_advisors_for_this_user.each do |advisor|
      n_ratings_for_advisor = all_user_projects_ratings.where(:user_id => advisor.id).pluck("DISTINCT project_id").count

      if Rateback.pr_counter(advisor.id, current_user.id).zero?
        first_time_advisor_count += 1

        next
      end

      if n_ratings_for_advisor < 5
        interested_advisors_count += 1
      end

      if n_ratings_for_advisor >= 5
        regular_advisors_count += 1
      end
    end

    first_time_students_count = 0
    interested_students_count = 0
    regular_students_count = 0

    all_ratings_from_user = Rating.where(:user_id => params[:id])
    all_rated_projects = Project.where(:id => all_ratings_from_user.collect(&:project_id))
    all_rated_students = User.where(:id => all_rated_projects.collect(&:user_id))

    all_rated_students.each do |student|
      rated_projects_of_student = all_rated_projects.where(:user_id => student.id)
      n_ratings_of_student = Rating.where(:project_id => rated_projects_of_student.collect(&:id)).pluck("DISTINCT project_id").count

      if n_ratings_of_student < 2
        first_time_students_count += 1
      end

      if n_ratings_of_student >= 2 &&  n_ratings_of_student < 5
        interested_students_count += 1
      end

      if n_ratings_of_student >= 5
        regular_students_count += 1
      end

    end




    res = {
      first_time_advisors: first_time_advisor_count,
      interested_advisors: interested_advisors_count,
      regular_advisors: regular_advisors_count,

      first_time_students: first_time_students_count,
      interested_students: interested_students_count,
      regular_students: regular_students_count
    }

    render json: res

  end

  def advisor_user_profile
    user = User.find(params[:id])
    render json: user, serializer: UserAdvisorSerializer, :root => 'user'
  end

  def register_referral
    user = User.find(params[:userID])
    referred_by_user = User.where(:referral_token => params[:referredByToken]).first
    user.referred_by = referred_by_user.id
    user.save!

    referral_bonus = Transaction.create(:transactiontype => 'referral_bonus', :value => Setting.where(:name => 'referral_bonus').first.value, :user_id => user.id)
    referral_bonus.save!

    referral_bonus_to_referred_by_user = Transaction.create(:transactiontype => 'referral_bonus', :value => Setting.where(:name => 'referral_bonus').first.value, :user_id => referred_by_user.id)
    referral_bonus_to_referred_by_user.save!

    render json: user

  end

  def addcard
    card = Card.find(params[:card_id])
    current_user.cards << card
    current_user.save!
    render json: current_user

  end

  def update
    if @user.update(user_params)
      render json: @user
    else
      render json: @user.errors, status: :unprocessable_entity
    end

  end

  def resend_confirmation
    user = User.find_by(email: params[:email])
    user.send_confirmation_instructions
    render json: user
  end

  def index


    if params[:sharetoken]

      usr = User.where(:sharetoken => params[:sharetoken]).first
      render json: usr, serializer:UserSerializer
    elsif params[:feedbackreceiver]


      ratings = Rating.where(:user_id => current_user.id)
      projects = Project.where(:id => ratings.collect(&:project_id) )
      users = User.where(:id => projects.collect(&:user_id));
      render json: users, each_serializer: SimpleuserSerializer

    elsif params[:feedbackgiver]

      ratings = Rating.where(:project_id => current_user.projects.collect(&:id)).where.not(user_id: current_user.id)
      users = User.where(:id => ratings.collect(&:user_id));
      render json: users, each_serializer: SimpleuserSerializer


    elsif params[:for_projects]
      project = Project.find(params[:project_id])
      relevant_ratings = Rating.where(:project_id => project.id)

      selected_ratings = []
      relevant_ratings.each do |rt|
        feedbacks_count = rt.feedbacks.count
        ratebacks_count = Rateback.where(:feedback_id => rt.feedbacks.collect(&:id)).count
        if feedbacks_count != ratebacks_count
          selected_ratings << rt
        end
      end

      @users = User.where(:id => Rating.where(:id => relevant_ratings).collect(&:user_id)).where.not(:id => Rating.where(:id => selected_ratings).collect(&:user_id))
      render json: @users
    elsif params[:team_project_rating]
      ratings = Rating.where(:project_id => params[:team_project_rating])
      @users = User.where(:admin => true).where.not(:id => ratings.collect(&:user_id))
      render json: @users
    else
      @users = User.all;
      render json: @users

    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:showtutorials, :time_zone,  :isteam, :hours, :days, :profileimage, :email,
                                   :advisorrate, :lang, :signup_form_shown, :gender, :image, :name, :image, :referred_by,
                                   :website, :city, :showimage, :showcity, :showname, :showwebsite, :online)
    end
end

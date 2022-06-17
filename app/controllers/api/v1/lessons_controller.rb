require 'jwt'

class Api::V1::LessonsController < ApplicationController
  before_action :set_lesson, only: [:show, :update, :destroy]
  before_action :authenticate_user!
  # GET /lessons
  def index
    @lessons = Lesson.all

    render json: @lessons
  end


  def close_room

    lesson = Lesson.find(params[:lessonID])
    lesson.end = Time.now
    lesson.seconds = params[:seconds]
    lesson.save!
    render json: lesson

  end

  def create_room

    studentID = lesson_params[:student_id]
    teacherID = lesson_params[:teacher_id]

    teacher = User.find(teacherID)

    hmac_secret = ''
    payload = {
      "context" => {
        "user" =>  {
          "user_id" => current_user.id,
          "avatar" => current_user.profileimage,
          "name" => (current_user.name ? current_user.name : current_user.id.to_s),
          "email" => current_user.email
        }
      },
      "iss" => "",
      "aud" => "",
      "sub" => "",
      "exp" => Time.now.to_i + 4 * 3600,
      "room" => teacherID.to_s + "_" + studentID.to_s
    }

    token = JWT.encode payload, hmac_secret, 'HS256', {typ: 'JWT'}

    lesson = Lesson.where(:teacher_id => teacherID, :student_id => studentID, :finished => false).first
    lesson.token = token
    lesson.name = teacherID.to_s  + "_" + studentID.to_s
    lesson.start = Time.now

    # lesson = Lesson.new({
    #   :token => token,
    #   :name => teacherID.to_s  + "_" + studentID.to_s,
    #   :start =>  Time.now,
    #   :teacher_id => teacherID,
    #   :student_id => studentID
    # })

    lesson.save!

    render json: lesson

  end

  # GET /lessons/1
  def show
    render json: @lesson
  end

  # POST /lessons
  def create
    @lesson = Lesson.new(lesson_params)

    if @lesson.save
      teacher  = User.find(@lesson.teacher_id)
      student =  User.find(@lesson.student_id)
      # MandrillUserMailer.sendVideoLessonRequestEmail(teacher, student, @lesson.meetingtime, opts={}).deliver_now
      render json: @lesson, status: :created
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end



  # PATCH/PUT /lessons/1
  def update
    if @lesson.update(lesson_params)
      render json: @lesson
    else
      render json: @lesson.errors, status: :unprocessable_entity
    end
  end

  # DELETE /lessons/1
  def destroy
    @lesson.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_lesson
      @lesson = Lesson.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def lesson_params
      params.require(:lesson).permit(:name, :conversation_id, :rated, :meetingtime, :confirmed, :paid, :finished,
                                     :project_id, :seconds, :token, :start, :end, :teacher_id, :student_id,
                                     :pronunciation_rate, :knowledge_rate, :explanation_rate, :positive_comment,
                                     :negative_comment, :paymentrequestapproved, :paymentrequestdenied)
    end
end

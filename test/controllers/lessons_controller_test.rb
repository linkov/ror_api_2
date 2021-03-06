require 'test_helper'

class LessonsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @lesson = lessons(:one)
  end

  test "should get index" do
    get lessons_url, as: :json
    assert_response :success
  end

  test "should create lesson" do
    assert_difference('Lesson.count') do
      post lessons_url, params: { lesson: { end: @lesson.end, explanation_rate: @lesson.explanation_rate, knowledge_rate: @lesson.knowledge_rate, negartive_comment: @lesson.negartive_comment, positive_comment: @lesson.positive_comment, pronunciation_rate: @lesson.pronunciation_rate, start: @lesson.start, student_id: @lesson.student_id, teacher_id: @lesson.teacher_id } }, as: :json
    end

    assert_response 201
  end

  test "should show lesson" do
    get lesson_url(@lesson), as: :json
    assert_response :success
  end

  test "should update lesson" do
    patch lesson_url(@lesson), params: { lesson: { end: @lesson.end, explanation_rate: @lesson.explanation_rate, knowledge_rate: @lesson.knowledge_rate, negartive_comment: @lesson.negartive_comment, positive_comment: @lesson.positive_comment, pronunciation_rate: @lesson.pronunciation_rate, start: @lesson.start, student_id: @lesson.student_id, teacher_id: @lesson.teacher_id } }, as: :json
    assert_response 200
  end

  test "should destroy lesson" do
    assert_difference('Lesson.count', -1) do
      delete lesson_url(@lesson), as: :json
    end

    assert_response 204
  end
end

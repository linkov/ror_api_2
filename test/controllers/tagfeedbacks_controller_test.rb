require 'test_helper'

class TagfeedbacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @tagfeedback = tagfeedbacks(:one)
  end

  test "should get index" do
    get tagfeedbacks_url, as: :json
    assert_response :success
  end

  test "should create tagfeedback" do
    assert_difference('Tagfeedback.count') do
      post tagfeedbacks_url, params: { tagfeedback: { arttag_id: @tagfeedback.arttag_id, count: @tagfeedback.count, feedback_id: @tagfeedback.feedback_id } }, as: :json
    end

    assert_response 201
  end

  test "should show tagfeedback" do
    get tagfeedback_url(@tagfeedback), as: :json
    assert_response :success
  end

  test "should update tagfeedback" do
    patch tagfeedback_url(@tagfeedback), params: { tagfeedback: { arttag_id: @tagfeedback.arttag_id, count: @tagfeedback.count, feedback_id: @tagfeedback.feedback_id } }, as: :json
    assert_response 200
  end

  test "should destroy tagfeedback" do
    assert_difference('Tagfeedback.count', -1) do
      delete tagfeedback_url(@tagfeedback), as: :json
    end

    assert_response 204
  end
end

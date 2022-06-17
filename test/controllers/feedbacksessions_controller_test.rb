require 'test_helper'

class FeedbacksessionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @feedbacksession = feedbacksessions(:one)
  end

  test "should get index" do
    get feedbacksessions_url, as: :json
    assert_response :success
  end

  test "should create feedbacksession" do
    assert_difference('Feedbacksession.count') do
      post feedbacksessions_url, params: { feedbacksession: { paid: @feedbacksession.paid, paymentamount: @feedbacksession.paymentamount } }, as: :json
    end

    assert_response 201
  end

  test "should show feedbacksession" do
    get feedbacksession_url(@feedbacksession), as: :json
    assert_response :success
  end

  test "should update feedbacksession" do
    patch feedbacksession_url(@feedbacksession), params: { feedbacksession: { paid: @feedbacksession.paid, paymentamount: @feedbacksession.paymentamount } }, as: :json
    assert_response 200
  end

  test "should destroy feedbacksession" do
    assert_difference('Feedbacksession.count', -1) do
      delete feedbacksession_url(@feedbacksession), as: :json
    end

    assert_response 204
  end
end

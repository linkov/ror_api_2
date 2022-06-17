require 'test_helper'

class RatebacksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @rateback = ratebacks(:one)
  end

  test "should get index" do
    get ratebacks_url, as: :json
    assert_response :success
  end

  test "should create rateback" do
    assert_difference('Rateback.count') do
      post ratebacks_url, params: { rateback: { feedback_id: @rateback.feedback_id, value: @rateback.value } }, as: :json
    end

    assert_response 201
  end

  test "should show rateback" do
    get rateback_url(@rateback), as: :json
    assert_response :success
  end

  test "should update rateback" do
    patch rateback_url(@rateback), params: { rateback: { feedback_id: @rateback.feedback_id, value: @rateback.value } }, as: :json
    assert_response 200
  end

  test "should destroy rateback" do
    assert_difference('Rateback.count', -1) do
      delete rateback_url(@rateback), as: :json
    end

    assert_response 204
  end
end

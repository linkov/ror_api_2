require 'test_helper'

class AvfeedbacklanesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @avfeedbacklane = avfeedbacklanes(:one)
  end

  test "should get index" do
    get avfeedbacklanes_url, as: :json
    assert_response :success
  end

  test "should create avfeedbacklane" do
    assert_difference('Avfeedbacklane.count') do
      post avfeedbacklanes_url, params: { avfeedbacklane: { avratingparam_id: @avfeedbacklane.avratingparam_id, rating_id: @avfeedbacklane.rating_id } }, as: :json
    end

    assert_response 201
  end

  test "should show avfeedbacklane" do
    get avfeedbacklane_url(@avfeedbacklane), as: :json
    assert_response :success
  end

  test "should update avfeedbacklane" do
    patch avfeedbacklane_url(@avfeedbacklane), params: { avfeedbacklane: { avratingparam_id: @avfeedbacklane.avratingparam_id, rating_id: @avfeedbacklane.rating_id } }, as: :json
    assert_response 200
  end

  test "should destroy avfeedbacklane" do
    assert_difference('Avfeedbacklane.count', -1) do
      delete avfeedbacklane_url(@avfeedbacklane), as: :json
    end

    assert_response 204
  end
end

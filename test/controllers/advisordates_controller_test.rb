require 'test_helper'

class AdvisordatesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @advisordate = advisordates(:one)
  end

  test "should get index" do
    get advisordates_url, as: :json
    assert_response :success
  end

  test "should create advisordate" do
    assert_difference('Advisordate.count') do
      post advisordates_url, params: { advisordate: { day: @advisordate.day, time: @advisordate.time, user_id: @advisordate.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show advisordate" do
    get advisordate_url(@advisordate), as: :json
    assert_response :success
  end

  test "should update advisordate" do
    patch advisordate_url(@advisordate), params: { advisordate: { day: @advisordate.day, time: @advisordate.time, user_id: @advisordate.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy advisordate" do
    assert_difference('Advisordate.count', -1) do
      delete advisordate_url(@advisordate), as: :json
    end

    assert_response 204
  end
end

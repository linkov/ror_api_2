require 'test_helper'

class ReviewqueuesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @reviewqueue = reviewqueues(:one)
  end

  test "should get index" do
    get reviewqueues_url, as: :json
    assert_response :success
  end

  test "should create reviewqueue" do
    assert_difference('Reviewqueue.count') do
      post reviewqueues_url, params: { reviewqueue: { project_id: @reviewqueue.project_id, user_id: @reviewqueue.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show reviewqueue" do
    get reviewqueue_url(@reviewqueue), as: :json
    assert_response :success
  end

  test "should update reviewqueue" do
    patch reviewqueue_url(@reviewqueue), params: { reviewqueue: { project_id: @reviewqueue.project_id, user_id: @reviewqueue.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy reviewqueue" do
    assert_difference('Reviewqueue.count', -1) do
      delete reviewqueue_url(@reviewqueue), as: :json
    end

    assert_response 204
  end
end

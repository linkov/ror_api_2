require 'test_helper'

class PresenterquestionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @presenterquestion = presenterquestions(:one)
  end

  test "should get index" do
    get presenterquestions_url, as: :json
    assert_response :success
  end

  test "should create presenterquestion" do
    assert_difference('Presenterquestion.count') do
      post presenterquestions_url, params: { presenterquestion: { project_id: @presenterquestion.project_id, title: @presenterquestion.title } }, as: :json
    end

    assert_response 201
  end

  test "should show presenterquestion" do
    get presenterquestion_url(@presenterquestion), as: :json
    assert_response :success
  end

  test "should update presenterquestion" do
    patch presenterquestion_url(@presenterquestion), params: { presenterquestion: { project_id: @presenterquestion.project_id, title: @presenterquestion.title } }, as: :json
    assert_response 200
  end

  test "should destroy presenterquestion" do
    assert_difference('Presenterquestion.count', -1) do
      delete presenterquestion_url(@presenterquestion), as: :json
    end

    assert_response 204
  end
end

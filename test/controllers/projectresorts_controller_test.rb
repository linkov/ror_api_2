require 'test_helper'

class ProjectresortsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @projectresort = projectresorts(:one)
  end

  test "should get index" do
    get projectresorts_url, as: :json
    assert_response :success
  end

  test "should create projectresort" do
    assert_difference('Projectresort.count') do
      post projectresorts_url, params: { projectresort: { comment: @projectresort.comment, project_id: @projectresort.project_id, user_id: @projectresort.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show projectresort" do
    get projectresort_url(@projectresort), as: :json
    assert_response :success
  end

  test "should update projectresort" do
    patch projectresort_url(@projectresort), params: { projectresort: { comment: @projectresort.comment, project_id: @projectresort.project_id, user_id: @projectresort.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy projectresort" do
    assert_difference('Projectresort.count', -1) do
      delete projectresort_url(@projectresort), as: :json
    end

    assert_response 204
  end
end

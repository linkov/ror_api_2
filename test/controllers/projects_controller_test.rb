require 'test_helper'

class ProjectsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @project = projects(:one)
  end

  test "should get index" do
    get projects_url, as: :json
    assert_response :success
  end

  test "should create project" do
    assert_difference('Project.count') do
      post projects_url, params: { project: { description: @project.description, title: @project.title, user_id: @project.user_id } }, as: :json
    end

    assert_response 201
  end

  
end

require 'test_helper'

class ProjectquestionanswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @projectquestionanswer = projectquestionanswers(:one)
  end

  test "should get index" do
    get projectquestionanswers_url, as: :json
    assert_response :success
  end

  test "should create projectquestionanswer" do
    assert_difference('Projectquestionanswer.count') do
      post projectquestionanswers_url, params: { projectquestionanswer: { answer: @projectquestionanswer.answer, project_id: @projectquestionanswer.project_id, user_id: @projectquestionanswer.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show projectquestionanswer" do
    get projectquestionanswer_url(@projectquestionanswer), as: :json
    assert_response :success
  end

  test "should update projectquestionanswer" do
    patch projectquestionanswer_url(@projectquestionanswer), params: { projectquestionanswer: { answer: @projectquestionanswer.answer, project_id: @projectquestionanswer.project_id, user_id: @projectquestionanswer.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy projectquestionanswer" do
    assert_difference('Projectquestionanswer.count', -1) do
      delete projectquestionanswer_url(@projectquestionanswer), as: :json
    end

    assert_response 204
  end
end

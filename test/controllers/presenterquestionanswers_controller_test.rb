require 'test_helper'

class PresenterquestionanswersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @presenterquestionanswer = presenterquestionanswers(:one)
  end

  test "should get index" do
    get presenterquestionanswers_url, as: :json
    assert_response :success
  end

  test "should create presenterquestionanswer" do
    assert_difference('Presenterquestionanswer.count') do
      post presenterquestionanswers_url, params: { presenterquestionanswer: { answer: @presenterquestionanswer.answer, presenterquestion_id: @presenterquestionanswer.presenterquestion_id, user_id: @presenterquestionanswer.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show presenterquestionanswer" do
    get presenterquestionanswer_url(@presenterquestionanswer), as: :json
    assert_response :success
  end

  test "should update presenterquestionanswer" do
    patch presenterquestionanswer_url(@presenterquestionanswer), params: { presenterquestionanswer: { answer: @presenterquestionanswer.answer, presenterquestion_id: @presenterquestionanswer.presenterquestion_id, user_id: @presenterquestionanswer.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy presenterquestionanswer" do
    assert_difference('Presenterquestionanswer.count', -1) do
      delete presenterquestionanswer_url(@presenterquestionanswer), as: :json
    end

    assert_response 204
  end
end

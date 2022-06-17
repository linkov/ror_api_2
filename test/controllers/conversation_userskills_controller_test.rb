require 'test_helper'

class ConversationUserskillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @conversation_userskill = conversation_userskills(:one)
  end

  test "should get index" do
    get conversation_userskills_url, as: :json
    assert_response :success
  end

  test "should create conversation_userskill" do
    assert_difference('ConversationUserskill.count') do
      post conversation_userskills_url, params: { conversation_userskill: { conversation_id: @conversation_userskill.conversation_id, user_skill_id: @conversation_userskill.user_skill_id } }, as: :json
    end

    assert_response 201
  end

  test "should show conversation_userskill" do
    get conversation_userskill_url(@conversation_userskill), as: :json
    assert_response :success
  end

  test "should update conversation_userskill" do
    patch conversation_userskill_url(@conversation_userskill), params: { conversation_userskill: { conversation_id: @conversation_userskill.conversation_id, user_skill_id: @conversation_userskill.user_skill_id } }, as: :json
    assert_response 200
  end

  test "should destroy conversation_userskill" do
    assert_difference('ConversationUserskill.count', -1) do
      delete conversation_userskill_url(@conversation_userskill), as: :json
    end

    assert_response 204
  end
end

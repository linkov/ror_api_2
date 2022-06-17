require 'test_helper'

class MyadvisersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @myadviser = myadvisers(:one)
  end

  test "should get index" do
    get myadvisers_url, as: :json
    assert_response :success
  end

  test "should create myadviser" do
    assert_difference('Myadviser.count') do
      post myadvisers_url, params: { myadviser: { adviserid: @myadviser.adviserid, user_id: @myadviser.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show myadviser" do
    get myadviser_url(@myadviser), as: :json
    assert_response :success
  end

  test "should update myadviser" do
    patch myadviser_url(@myadviser), params: { myadviser: { adviserid: @myadviser.adviserid, user_id: @myadviser.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy myadviser" do
    assert_difference('Myadviser.count', -1) do
      delete myadviser_url(@myadviser), as: :json
    end

    assert_response 204
  end
end

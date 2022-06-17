require 'test_helper'

class NewsfeedfollowsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @newsfeedfollow = newsfeedfollows(:one)
  end

  test "should get index" do
    get newsfeedfollows_url, as: :json
    assert_response :success
  end

  test "should create newsfeedfollow" do
    assert_difference('Newsfeedfollow.count') do
      post newsfeedfollows_url, params: { newsfeedfollow: { artist_id: @newsfeedfollow.artist_id, commenter_id: @newsfeedfollow.commenter_id, user_id: @newsfeedfollow.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show newsfeedfollow" do
    get newsfeedfollow_url(@newsfeedfollow), as: :json
    assert_response :success
  end

  test "should update newsfeedfollow" do
    patch newsfeedfollow_url(@newsfeedfollow), params: { newsfeedfollow: { artist_id: @newsfeedfollow.artist_id, commenter_id: @newsfeedfollow.commenter_id, user_id: @newsfeedfollow.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy newsfeedfollow" do
    assert_difference('Newsfeedfollow.count', -1) do
      delete newsfeedfollow_url(@newsfeedfollow), as: :json
    end

    assert_response 204
  end
end

require 'test_helper'

class ArttagsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @arttag = arttags(:one)
  end

  test "should get index" do
    get arttags_url, as: :json
    assert_response :success
  end

  test "should create arttag" do
    assert_difference('Arttag.count') do
      post arttags_url, params: { arttag: { name: @arttag.name } }, as: :json
    end

    assert_response 201
  end

  test "should show arttag" do
    get arttag_url(@arttag), as: :json
    assert_response :success
  end

  test "should update arttag" do
    patch arttag_url(@arttag), params: { arttag: { name: @arttag.name } }, as: :json
    assert_response 200
  end

  test "should destroy arttag" do
    assert_difference('Arttag.count', -1) do
      delete arttag_url(@arttag), as: :json
    end

    assert_response 204
  end
end

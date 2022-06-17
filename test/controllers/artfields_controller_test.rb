require 'test_helper'

class ArtfieldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artfield = artfields(:one)
  end

  test "should get index" do
    get artfields_url, as: :json
    assert_response :success
  end

  test "should create artfield" do
    assert_difference('Artfield.count') do
      post artfields_url, params: { artfield: { name: @artfield.name, tag: @artfield.tag } }, as: :json
    end

    assert_response 201
  end

  test "should show artfield" do
    get artfield_url(@artfield), as: :json
    assert_response :success
  end

  test "should update artfield" do
    patch artfield_url(@artfield), params: { artfield: { name: @artfield.name, tag: @artfield.tag } }, as: :json
    assert_response 200
  end

  test "should destroy artfield" do
    assert_difference('Artfield.count', -1) do
      delete artfield_url(@artfield), as: :json
    end

    assert_response 204
  end
end

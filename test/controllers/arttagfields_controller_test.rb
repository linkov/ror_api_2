require 'test_helper'

class ArttagfieldsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @arttagfield = arttagfields(:one)
  end

  test "should get index" do
    get arttagfields_url, as: :json
    assert_response :success
  end

  test "should create arttagfield" do
    assert_difference('Arttagfield.count') do
      post arttagfields_url, params: { arttagfield: { name: @arttagfield.name } }, as: :json
    end

    assert_response 201
  end

  test "should show arttagfield" do
    get arttagfield_url(@arttagfield), as: :json
    assert_response :success
  end

  test "should update arttagfield" do
    patch arttagfield_url(@arttagfield), params: { arttagfield: { name: @arttagfield.name } }, as: :json
    assert_response 200
  end

  test "should destroy arttagfield" do
    assert_difference('Arttagfield.count', -1) do
      delete arttagfield_url(@arttagfield), as: :json
    end

    assert_response 204
  end
end

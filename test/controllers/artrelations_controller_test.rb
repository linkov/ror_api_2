require 'test_helper'

class ArtrelationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artrelation = artrelations(:one)
  end

  test "should get index" do
    get artrelations_url, as: :json
    assert_response :success
  end

  test "should create artrelation" do
    assert_difference('Artrelation.count') do
      post artrelations_url, params: { artrelation: { fromcategory_id: @artrelation.fromcategory_id, tocategory_id: @artrelation.tocategory_id, weight: @artrelation.weight } }, as: :json
    end

    assert_response 201
  end

  test "should show artrelation" do
    get artrelation_url(@artrelation), as: :json
    assert_response :success
  end

  test "should update artrelation" do
    patch artrelation_url(@artrelation), params: { artrelation: { fromcategory_id: @artrelation.fromcategory_id, tocategory_id: @artrelation.tocategory_id, weight: @artrelation.weight } }, as: :json
    assert_response 200
  end

  test "should destroy artrelation" do
    assert_difference('Artrelation.count', -1) do
      delete artrelation_url(@artrelation), as: :json
    end

    assert_response 204
  end
end

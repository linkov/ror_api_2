require 'test_helper'

class CategoryrelationsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @categoryrelation = categoryrelations(:one)
  end

  test "should get index" do
    get categoryrelations_url, as: :json
    assert_response :success
  end

  test "should create categoryrelation" do
    assert_difference('Categoryrelation.count') do
      post categoryrelations_url, params: { categoryrelation: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show categoryrelation" do
    get categoryrelation_url(@categoryrelation), as: :json
    assert_response :success
  end

  test "should update categoryrelation" do
    patch categoryrelation_url(@categoryrelation), params: { categoryrelation: {  } }, as: :json
    assert_response 200
  end

  test "should destroy categoryrelation" do
    assert_difference('Categoryrelation.count', -1) do
      delete categoryrelation_url(@categoryrelation), as: :json
    end

    assert_response 204
  end
end

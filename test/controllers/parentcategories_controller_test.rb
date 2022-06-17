require 'test_helper'

class ParentcategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @parentcategory = parentcategories(:one)
  end

  test "should get index" do
    get parentcategories_url, as: :json
    assert_response :success
  end

  test "should create parentcategory" do
    assert_difference('Parentcategory.count') do
      post parentcategories_url, params: { parentcategory: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show parentcategory" do
    get parentcategory_url(@parentcategory), as: :json
    assert_response :success
  end

  test "should update parentcategory" do
    patch parentcategory_url(@parentcategory), params: { parentcategory: {  } }, as: :json
    assert_response 200
  end

  test "should destroy parentcategory" do
    assert_difference('Parentcategory.count', -1) do
      delete parentcategory_url(@parentcategory), as: :json
    end

    assert_response 204
  end
end

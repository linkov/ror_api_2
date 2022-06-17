require 'test_helper'

class SkipsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @skip = skips(:one)
  end

  test "should get index" do
    get skips_url, as: :json
    assert_response :success
  end

  test "should create skip" do
    assert_difference('Skip.count') do
      post skips_url, params: { skip: { category_id: @skip.category_id, parentcategory_id: @skip.parentcategory_id, project_id: @skip.project_id, skiptime: @skip.skiptime, user_id: @skip.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show skip" do
    get skip_url(@skip), as: :json
    assert_response :success
  end

  test "should update skip" do
    patch skip_url(@skip), params: { skip: { category_id: @skip.category_id, parentcategory_id: @skip.parentcategory_id, project_id: @skip.project_id, skiptime: @skip.skiptime, user_id: @skip.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy skip" do
    assert_difference('Skip.count', -1) do
      delete skip_url(@skip), as: :json
    end

    assert_response 204
  end
end

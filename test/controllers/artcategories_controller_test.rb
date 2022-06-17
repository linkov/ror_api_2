require 'test_helper'

class ArtcategoriesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artcategory = artcategories(:one)
  end

  test "should get index" do
    get artcategories_url, as: :json
    assert_response :success
  end

  test "should create artcategory" do
    assert_difference('Artcategory.count') do
      post artcategories_url, params: { artcategory: { name: @artcategory.name, parent_id: @artcategory.parent_id } }, as: :json
    end

    assert_response 201
  end

  test "should show artcategory" do
    get artcategory_url(@artcategory), as: :json
    assert_response :success
  end

  test "should update artcategory" do
    patch artcategory_url(@artcategory), params: { artcategory: { name: @artcategory.name, parent_id: @artcategory.parent_id } }, as: :json
    assert_response 200
  end

  test "should destroy artcategory" do
    assert_difference('Artcategory.count', -1) do
      delete artcategory_url(@artcategory), as: :json
    end

    assert_response 204
  end
end

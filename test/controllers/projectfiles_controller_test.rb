require 'test_helper'

class ProjectfilesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @projectfile = projectfiles(:one)
  end

  test "should get index" do
    get projectfiles_url, as: :json
    assert_response :success
  end

  test "should create projectfile" do
    assert_difference('Projectfile.count') do
      post projectfiles_url, params: { projectfile: {  } }, as: :json
    end

    assert_response 201
  end

  test "should show projectfile" do
    get projectfile_url(@projectfile), as: :json
    assert_response :success
  end

  test "should update projectfile" do
    patch projectfile_url(@projectfile), params: { projectfile: {  } }, as: :json
    assert_response 200
  end

  test "should destroy projectfile" do
    assert_difference('Projectfile.count', -1) do
      delete projectfile_url(@projectfile), as: :json
    end

    assert_response 204
  end
end

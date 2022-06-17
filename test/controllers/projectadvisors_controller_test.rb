require 'test_helper'

class ProjectadvisorsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @projectadvisor = projectadvisors(:one)
  end

  test "should get index" do
    get projectadvisors_url, as: :json
    assert_response :success
  end

  test "should create projectadvisor" do
    assert_difference('Projectadvisor.count') do
      post projectadvisors_url, params: { projectadvisor: { invitesent: @projectadvisor.invitesent, myadviser_id: @projectadvisor.myadviser_id, project_id: @projectadvisor.project_id } }, as: :json
    end

    assert_response 201
  end

  test "should show projectadvisor" do
    get projectadvisor_url(@projectadvisor), as: :json
    assert_response :success
  end

  test "should update projectadvisor" do
    patch projectadvisor_url(@projectadvisor), params: { projectadvisor: { invitesent: @projectadvisor.invitesent, myadviser_id: @projectadvisor.myadviser_id, project_id: @projectadvisor.project_id } }, as: :json
    assert_response 200
  end

  test "should destroy projectadvisor" do
    assert_difference('Projectadvisor.count', -1) do
      delete projectadvisor_url(@projectadvisor), as: :json
    end

    assert_response 204
  end
end

require 'test_helper'

class ArtcategorySkillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @artcategory_skill = artcategory_skills(:one)
  end

  test "should get index" do
    get artcategory_skills_url, as: :json
    assert_response :success
  end

  test "should create artcategory_skill" do
    assert_difference('ArtcategorySkill.count') do
      post artcategory_skills_url, params: { artcategory_skill: { artcategory_id: @artcategory_skill.artcategory_id, skill_id: @artcategory_skill.skill_id } }, as: :json
    end

    assert_response 201
  end

  test "should show artcategory_skill" do
    get artcategory_skill_url(@artcategory_skill), as: :json
    assert_response :success
  end

  test "should update artcategory_skill" do
    patch artcategory_skill_url(@artcategory_skill), params: { artcategory_skill: { artcategory_id: @artcategory_skill.artcategory_id, skill_id: @artcategory_skill.skill_id } }, as: :json
    assert_response 200
  end

  test "should destroy artcategory_skill" do
    assert_difference('ArtcategorySkill.count', -1) do
      delete artcategory_skill_url(@artcategory_skill), as: :json
    end

    assert_response 204
  end
end

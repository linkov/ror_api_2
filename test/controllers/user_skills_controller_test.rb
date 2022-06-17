require 'test_helper'

class UserSkillsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user_skill = user_skills(:one)
  end

  test "should get index" do
    get user_skills_url, as: :json
    assert_response :success
  end

  test "should create user_skill" do
    assert_difference('UserSkill.count') do
      post user_skills_url, params: { user_skill: { level: @user_skill.level, rate: @user_skill.rate, skill_id: @user_skill.skill_id, user_id: @user_skill.user_id } }, as: :json
    end

    assert_response 201
  end

  test "should show user_skill" do
    get user_skill_url(@user_skill), as: :json
    assert_response :success
  end

  test "should update user_skill" do
    patch user_skill_url(@user_skill), params: { user_skill: { level: @user_skill.level, rate: @user_skill.rate, skill_id: @user_skill.skill_id, user_id: @user_skill.user_id } }, as: :json
    assert_response 200
  end

  test "should destroy user_skill" do
    assert_difference('UserSkill.count', -1) do
      delete user_skill_url(@user_skill), as: :json
    end

    assert_response 204
  end
end

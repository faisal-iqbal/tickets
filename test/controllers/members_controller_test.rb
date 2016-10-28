require 'test_helper'

class MembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @member = users(:one)
  end

  test "should get index" do
    get members_url
    assert_response :success
  end

  test "should get new" do
    get new_member_url
    assert_response :success
  end

  test "should create member" do
    assert_difference('Member.count') do
      post members_url, params: { user: { email: @member.email, role: @member.role } }
    end

    assert_redirected_to member_url(Member.last)
  end

  test "should show member" do
    get member_url(id:@member.id)
    assert_response :success
  end

  test "should get edit" do
    get edit_member_url(id:@member.id)
    assert_response :success
  end

  test "should update member" do
    patch member_url(id:@member.id), params: { user: { email: @member.email, role: @member.role } }
    assert_redirected_to member_url(id:@member.id)
  end

  test "should destroy member" do
    assert_difference('Member.count', -1) do
      delete member_url(id:@member.id)
    end

    assert_redirected_to members_url
  end
end

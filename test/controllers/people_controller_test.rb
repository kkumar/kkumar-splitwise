require "test_helper"

class PeopleControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    sign_in @user  # Assuming you have a method to handle sign-in in tests
  end

  test "should get show for self" do
    connected_user = users(:two)
    get person_url(connected_user)
    assert_response :success
  end

  test "should not get show for another user not connected" do
    other_user = users(:three)
    get person_url(other_user)
    assert_redirected_to root_url
  end
end

require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url # "/"

    # save_and_open_screenshot
    assert_selector "h5", text: "With Keep Running, find the best way to optimize your sport activities"
  end

  test "user can visit the sign in page" do
    visit new_user_session_path
    # save_and_open_screenshot
    assert_selector "p", text: "Connect now"
  end

  # test "user can sign in" do
  #   visit /users/sign_in
  #   click on "Connect with Strava"
  # end
end

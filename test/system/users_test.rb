require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url # "/"

    # save_and_open_screenshot
    assert_selector "h5", text: "With Keep Running, find the best way to optimize your sport activities"
  end

  test "visiting the sign_in" do
    visit new_user_session_path

    # save_and_open_screenshot
    # change assert_selector for the button
    assert_selector "p", text: "Connect now"
  end

  test "user can sign in with Strava" do
    # user visits sign_in page and clicks on the connect button
    visit new_user_session_path
    find('.stravalogin').click
    # accept_alert do
    #   click_button '.stravalogin'
    # end

  #   # user enters his Strava credentials and authorizes
  #   # fill_in "Email", with: "111400793@strava.com"
  #   # find('.btn-primary').click
  # end
end


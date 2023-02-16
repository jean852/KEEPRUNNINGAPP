require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase
  test "visiting the index" do
    visit root_url # "/"

    # save_and_open_screenshot
    assert_selector "h5", text: "With Keep Running, find the best way to optimize your sport activities"
  end

  test "visiting the sign_in" do
    visit new_user_session_path
    assert_selector "p", text: "Connect now"
  end

  test "user can sign up with Strava" do
    # user visits sign_in page and clicks on the connect button
    visit new_user_session_path
    sleep 1
    accept_alert do
      find('.stravalogin').click
    end
    sleep 1
    assert_selector "h1", text: "Log In"
    # save_and_open_screenshot

    # user enters their Strava credentials and clicks on the login button
    find('#email').fill_in with: ENV.fetch('STRAVA_TEST_EMAIL')
    find('#password').fill_in with: ENV.fetch('STRAVA_TEST_PASSWORD')
    find('#login-button').click

    # user checks the checkbox's, authorizes Strava API and lands on dashboard

    assert_selector "h3", text: "Authorize KeepRunning to connect to Strava"
    check "View your private non-activity data such as segments and routes"
    check "View data about your private activities"
    find('#authorize').click
    # save_and_open_screenshot
    assert_equal "/dashboard", page.current_path
  end
end

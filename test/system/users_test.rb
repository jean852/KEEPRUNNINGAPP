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

  test "user can sign in with Strava" do
    # user visits sign_in page and clicks on the connect button

    visit new_user_session_path
    sleep 1
    accept_alert do
      find('.stravalogin').click
    end
    sleep 1
    assert_selector "h1", text: "Log In"

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

  test "user can create a challenge" do
    # user visits dashboard and clicks on the create challenge button

    visit dashboard_path
    click_link "New Challenge"
    assert_current_path new_challenge_path

    # user fills in the challenge name and clicks on which activity type they want to challenge and the continue button

    find('#challenge_name').fill_in with: "My test challenge"
    find('div[data-action="click->activity#running"]').click
    find('div[data-action="click->step#to_step2"]').click

    # user selects the challenge type (How far) and clicks on the continue button

    assert_selector('.supertitle-gradient', text: "Select your")
    find('div[data-action="click->challengetype#km"]').click
    find('div[data-action="click->step#to_step3"]').click

    # user fills in the form and clicks on the create button

    find('#challenge_target_distance').fill_in with: 100
    find('#challenge_start_date').fill_in with: "2020-03-01"
    find('#challenge_end_date').fill_in with: "2020-03-31"
    find('div[data-action="click->step#to_step4"]').click

    # user creates an optional bet

    assert_selector "h2", text: "Bet on your success!"
    find('#challenge_price').fill_in with: 10
    click_button 'Create Challenge'
    assert_selector('.supertitle-gradient', text: "Time")
    find('#pay').click

    # user is redirected to stripe and fills in the payment details

    find('#email').fill_in with: ENV.fetch('GMAIL_ACCOUNT')
    find('#cardNumber').fill_in with: "4242 4242 4242 4242"
    find('#cardExpiry').fill_in with: "01/24"
    find('#cardCvc').fill_in with: "123"
    find('#billingName').fill_in with: "Jean Dupont"
    find('#billingCountry').fill_in with: "France"
    find('.SubmitButton').click

    # user is redirected to the dashboard and sees the challenge

    assert_equal "/dashboard", page.current_path
  end
end

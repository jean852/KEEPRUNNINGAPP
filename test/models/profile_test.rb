require 'test_helper'

class ProfileTest < ActiveSupport::TestCase
  fixtures :users, :profiles

  test "validations" do
    profile = Profile.new(
      user_id: users(:user).id,
      first_name: "John",
      last_name: "Doe",
      country: "USA",
      username: "johndoe",
      sex: "Male",
      profile_url: "https://www.strava.com/athletes/${user.id}"
    )
    assert profile.valid?
  end

  # test ".create_profile_from_strava creates a new profile for the user if one doesn't exist" do
  #   assert_difference 'Profile.count' do
  #     profile = Profile.create_profile_from_strava(@provider_data, @user)
  #     assert_equal @user.id, profile.user_id
  #     assert_equal @provider_data.athlete.firstname, profile.first_name
  #     assert_equal @provider_data.athlete.lastname, profile.last_name
  #     assert_equal @provider_data.athlete.username, profile.username
  #     assert_equal @provider_data.athlete.sex, profile.sex
  #     assert_equal @provider_data.athlete.profile, profile.profile_url
  #   end
  # end

  # test ".create_profile_from_strava returns an existing profile for the user if one already exists" do
  #   existing_profile = create(:profile, user: @user)

  #   assert_no_difference 'Profile.count' do
  #     profile = Profile.create_profile_from_strava(@provider_data, @user)
  #     assert_equal existing_profile, profile
  #   end
  # end
end

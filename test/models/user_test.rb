require "test_helper"

class UserTest < ActiveSupport::TestCase
  # create a unit test for the model
  # test "user attributes must not be empty" do
  #   # create a new user object
  #   user = User.new
  #   # assert that the user object is not valid
  #   assert user.invalid?
  #   # assert that the user object has errors on the :name attribute
  #   assert user.errors[:name].any?
  #   # assert that the user object has errors on the :email attribute
  #   assert user.errors[:email].any?
  # end

  test "create user from provider data" do
    provider_data = Struct.new(provider: 'facebook', uid: '12345', info: Struct.new(email: 'test@example.com'))
    user = User.create_from_provider_data(provider_data)
    assert_equal 'test@example.com', user.email
  end

  test "create user from strava" do
    provider_data = Struct.new(:athlete).new(Struct.new(:id).new(321))
    user = User.create_from_strava(provider_data)
    assert_equal '321@strava.com', user.email
    assert_equal 321, user.athlete_id
  end

  test "calculate total distance in the last 30 days" do
    user = users(:one) # use fixture data or create a new user as needed
    user.activities.create(start_date: 29.days.ago, distance: 5) # should be included in total
    user.activities.create(start_date: 31.days.ago, distance: 10) # should be excluded from total
    assert_equal 5, user.total_km_thirty_days
  end
end

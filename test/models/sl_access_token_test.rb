require "test_helper"

class SlAccessTokenTest < ActiveSupport::TestCase
  # create a unit test for the model
  test "sl access token attributes must not be empty" do
    # create a new user object
    sl_access_token = SlAccessToken.new
    # assert that the user object is not valid
    assert sl_access_token.invalid?
    # assert that the user object has errors on the :name attribute
    assert sl_access_token.errors[:user_id].any?
    # assert that the user object has errors on the :email attribute
    assert sl_access_token.errors[:access_token].any?
  end
end

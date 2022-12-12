class OmniauthController < Devise::OmniauthCallbacksController
  def strava
    puts "we are in the strava method"
    # NORMAL PROCESS OF CREATING USER
    @user = User.create_from_provider_data(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Strava') if is_navigational_format?
    else
      flash[:error] = 'There was a problem signing you in through Strava. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end
  end

  def failure
    a = params['code']
    response = get_access_token!(a)
    @user = User.create_from_strava(response)
    @user.save!

    if @user.persisted?
      puts "if persited was true"
      # create linked profile
      newprofile = Profile.create_profile_from_strava(response, @user)
      newprofile.save!

      # create refresh token entry
      newrefreshtoken = RefreshToken.create_refresh_token_from_strava(response, @user)
      newrefreshtoken.save!

      # create short lived access token entry
      newshortlivedaccesstoken = SlAccessToken.create_sl_access_token_from_strava(response, @user)
      newshortlivedaccesstoken.save!

      # load activites
      GetUserActivitiesJob.perform_now(@user)

      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Strava') if is_navigational_format?
    else
      puts "if persited was false"
      flash[:error] = 'There was a problem signing you in through Strava. Please register or try signing in later.'
      redirect_to new_user_session_url
    end

    # redirect_to root
  end

  def oauth_client
    @oauth_client ||= Strava::OAuth::Client.new(
      client_id: Rails.application.credentials.dig(:strava, :strava_client_id),
      client_secret: Rails.application.credentials.dig(:strava, :strava_client_secret)
    )
  end

  def get_access_token!(code)
    oauth_client.oauth_token(code: code, grant_type: 'authorization_code')
  end
end

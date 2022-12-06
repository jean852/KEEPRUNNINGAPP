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
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Strava') if is_navigational_format?
    else
      puts "if persited was false"
      flash[:error] = 'There was a problem signing you in through Strava. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end

    # redirect_to new_user_registration_url
  end

  def oauth_client
    @oauth_client ||= Strava::OAuth::Client.new(
      client_id: ENV.fetch('STRAVA_CLIENT_ID', nil),
      client_secret: ENV.fetch('STRAVA_CLIENT_SECRET', nil)
    )
  end

  def get_access_token!(code)
    oauth_client.oauth_token(code:, grant_type: 'authorization_code')
  end
end

class OmniauthController < Devise::OmniauthCallbacksController

  def strava

    puts "we are in the strava method"
    # NORMAL PROCESS OF CREATING USER
    @user = User.create_from_provider_data(request.env['omniauth.auth'])

    if @user.persisted?
      sign_in_and_redirect @user
      set_flash_message(:notice, :success, kind: 'Strava') if is_navigational_format?
    else
      flash[:error]='There was a problem signing you in through Strava. Please register or try signing in later.'
      redirect_to new_user_registration_url
    end
  end

  def failure
    # WE USE THE FIRST FAILURE TO EXCHANGE CODE
    # puts "we are in the failure method"
    a = params['code']
    # puts a
    response = get_access_token!(a)
    # puts "here is the response"
    # p response
    # puts "here is the access token"
    # p response.access_token
    @user = User.create_from_strava(response)
    raise



    # flash[:error] = 'There was a problem signing you in. Please register or try signing in later.'
    # redirect_to new_user_registration_url
  end

  def oauth_client
    @oauth_client ||= Strava::OAuth::Client.new(
      client_id: ENV.fetch('STRAVA_CLIENT_ID', nil),
      client_secret: ENV.fetch('STRAVA_CLIENT_SECRET', nil)
    )
  end

  def get_access_token!(code)
    oauth_client.oauth_token(code: code, grant_type: 'authorization_code')
  end



end

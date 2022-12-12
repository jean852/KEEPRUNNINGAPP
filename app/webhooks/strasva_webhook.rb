class StrasvaWebhook < ApplicationController
def auth
  Strava::OAuth.configure do |config|
  config.client_id = "98174", # Strava client ID
  config.client_secret = "ccc937bb2bfc0f1f4a4f33ded9dd211e41270f1e" # Strava client secret
end

client = Strava::OAuth::Client.new(
  client_id:"98174",
  client_secret: "ccc937bb2bfc0f1f4a4f33ded9dd211e41270f1e",
)
end


http://www.strava.com/oauth/authorize?client_id=98174&response_type=code&redirect_uri=http://localhost/exchange_token&approval_prompt=force&scope=read,activity:read_all

CLIENT_SECRET = 272a8d719e6b21b1784d85e9d9d963387e067672

	curl -X POST https://www.strava.com/oauth/token \
	-F client_id=98174 \
	-F client_secret=272a8d719e6b21b1784d85e9d9d963387e067672 \
	-F code=9042b5d38879659ada21bbe6064485525c8603e8 \
	-F grant_type=authorization_code

response_type
{"token_type":"Bearer","expires_at":1670512018,"expires_in":17109,"refresh_token":"e688c6d678434c23e2aedbf479652e3e2ac9b88c","access_token":"3d93e97ef697aa1c7e6903cdb4ae62992b37497c","athlete":{"id":44057827,"username":"edouard_chandavoine","resource_state":2,"firstname":"Edouard","lastname":"Chandavoine","bio":null,"city":null,"state":null,"country":null,"sex":"M","premium":false,"summit":false,"created_at":"2019-07-08T11:30:44Z","updated_at":"2022-12-07T15:44:26Z","badge_type_id":0,"weight":0.0,"profile_medium":"https://graph.facebook.com/10157054665175255/picture?height=256\u0026width=256","profile":"https://graph.facebook.com/10157054665175255/picture?height=256\u0026width=256","friend":null,"follower":null}}%

	curl -X POST https://www.strava.com/oauth/token \
	-F client_id=98174 \
	-F client_secret=272a8d719e6b21b1784d85e9d9d963387e067672 \
	-F code=9b5447097ec19087d9e4ac3c5ce1bd3fc24f2d3d \
	-F grant_type=authorization_code



curl -X POST \
  https://www.strava.com/api/v3/push_subscriptions \
  -F client_id=97925 \
  -F client_secret=16aabbc6e337c4c839bd7f38116e793e98b7fb4d \
  -F callback_url=https://www.keeprunning.app/webhook \
  -F verify_token=STRAVA


  #get activities
curl -X GET \
https://www.strava.com/api/v3/athlete/activities?before=&after=&page=&per_page= \
-F Authorization: Bearer [e3fac8e70ac30f448bbe02796816e32bf6d52c3a]


#list subscribton

curl -G https://www.strava.com/api/v3/push_subscriptions \
    -d client_id=98174 \
    -d client_secret=272a8d719e6b21b1784d85e9d9d963387e067672
#test
curl -X POST {https://5f30-2a01-cb19-a2e-bf00-7d38-5252-88c2-d0e3.eu.ngrok.io} -H ‘Content-Type: application/json’

 -d ‘{
      “aspect_type”: “create”,
      “event_time”: 1549560669,
      “object_id”: 44057827,
      “object_type”: “activity”,
      “owner_id”: 44057827,
      “subscription_id”: 230942
    }’

    #delete subscription
    curl -X DELETE https://www.strava.com/api/v3/push_subscriptions/231111 \
    -F client_id=98174 \
    -F client_secret=272a8d719e6b21b1784d85e9d9d963387e067672


    #STRAVA_CLIENT_ID=97925
#STRAVA_CLIENT_SECRET=16aabbc6e337c4c839bd7f38116e793e98b7fb4d

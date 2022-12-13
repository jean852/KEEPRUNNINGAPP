require 'net/http'
namespace :webhook do
  desc "Get subscribed to webhooks"
  task subscription: :environment do
    puts "Subscribing to webhook..."
    uri = URI('https://www.strava.com/api/v3/push_subscriptions')
    req = Net::HTTP::Post.new(uri)
    req.set_form(
  [
    [
      'client_id',
      'ENV['STRAVA_CLIENT_ID']'
    ],
    [
      'client_secret',
      'ENV['STRAVA_CLIENT_SECRET']'
    ],
    [
      'callback_url',
      'ENV['STRAVA_CALLBACK_URL']'
    ],
    [
      'verify_token',
      'STRAVA'
    ]
  ],
  'multipart/form-data'
)

    req_options = {
      use_ssl: uri.scheme == 'https'
    }

    res = Net::HTTP.start(uri.hostname, uri.port, req_options) do |http|
      http.request(req)
    end

    case res
    when Net::HTTPSuccess, Net::HTTPRedirection
      # OK
    puts "sucessfully created subscription..."

    else
      res.value
    end
  end
    puts "Rake finished..."

end

# ENV['STRAVA_CLIENT_ID']
# ENV['STRAVA_CLIENT_SECRET']
# ENV['STRAVA_CALLBACK_URL']
# curl -G https://www.strava.com/api/v3/push_subscriptions \
#     -d client_id=98174 \
#     -d client_secret=272a8d719e6b21b1784d85e9d9d963387e067672

# curl -X DELETE https://www.strava.com/api/v3/push_subscriptions/231192 \
#     -F client_id=98174 \
#     -F client_secret=272a8d719e6b21b1784d85e9d9d963387e067672

# curl -X POST https://www.strava.com/api/v3/push_subscriptions \
#       -F client_id=98174 \
#       -F client_secret=272a8d719e6b21b1784d85e9d9d963387e067672 \
#       -F callback_url=https://5db6-2a01-cb19-a2e-bf00-2059-2875-25d8-898e.eu.ngrok.io/webhook \
#       -F verify_token=STRAVA

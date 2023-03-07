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
          ENV.fetch('STRAVA_CLIENT_ID', nil)
        ],
        [
          'client_secret',
          ENV.fetch('STRAVA_CLIENT_SECRET', nil)
        ],
        [
          'callback_url',
          ENV.fetch('STRAVA_CALLBACK_URL', nil)
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
#      -d client_id=98174 \
#      -d client_secret=272a8d719e6b21b1784d85e9d9d963387e067672

# curl -X DELETE https://www.strava.com/api/v3/push_subscriptions/231193 \
#      -F client_id=98174 \
#      -F client_secret=272a8d719e6b21b1784d85e9d9d963387e067672

#  curl -X POST https://www.strava.com/api/v3/push_subscriptions \
#        -F client_id=97925 \
#        -F client_secret=16aabbc6e337c4c839bd7f38116e793e98b7fb4d \
#        -F callback_url=https://www.keeprunning.app/webhook \
#        -F verify_token=STRAVA

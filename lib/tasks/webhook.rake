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
          '98174'
        ],
        [
          'client_secret',
          '272a8d719e6b21b1784d85e9d9d963387e067672'
        ],
        [
          'callback_url',
          'https://7f51-2a01-cb19-a2e-bf00-7c61-97b9-8b5-40d1.eu.ngrok.io/webhook'
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
      puts "sucessfully created subscription..."

    else
      res.value
    end
  end
    puts "Rake finished..."
end

# curl -G https://www.strava.com/api/v3/push_subscriptions \
#     -d client_id=98174 \
#     -d client_secret=272a8d719e6b21b1784d85e9d9d963387e067672

# curl -X DELETE https://www.strava.com/api/v3/push_subscriptions/231112 \
#     -F client_id=98174 \
#     -F client_secret=272a8d719e6b21b1784d85e9d9d963387e067672

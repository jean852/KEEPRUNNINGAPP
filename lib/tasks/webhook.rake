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
          'ccc937bb2bfc0f1f4a4f33ded9dd211e41270f1e'
        ],
        [
          'callback_url',
          'https://5db6-2a01-cb19-a2e-bf00-2059-2875-25d8-898e.eu.ngrok.io/webhook'
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

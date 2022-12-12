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
          Rails.application.credentials.dig(:strava, :strava_client_id)
        ],
        [
          'client_secret',
          Rails.application.credentials.dig(:strava, :strava_client_secret)
        ],
        [
          'callback_url',
          'https://www.keeprunning.app/webhook'
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

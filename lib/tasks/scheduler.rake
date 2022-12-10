desc "Get new short-lived access token for all existing users"
task refresh_token: :environment do
  users = User.all
  puts "Enqueuing SL Access Token refresh for #{users.size} users..."
  users.each do |user|
    RefreshtokenJob.perform_later(user)
  end
end

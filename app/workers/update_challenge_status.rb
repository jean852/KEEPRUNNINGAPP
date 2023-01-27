class UpdateChallengeStatus
  include Sidekiq::Worker
  require 'date'

  def perform
    challenges = Challenge.all
    challenges.each do |challenge|
      if challenge.challenge_type == "KM" && challenge.target_distance <= challenge.all_activities_km
        challenge.update(status: 'Completed')
      elsif challenge.challenge_type == "Sessions" && challenge.target_sessions <= challenge.all_activities_sessions
        challenge.update(status: 'Completed')
      elsif challenge.status == 'Not started'
        if Date.today >= challenge.start_date && Date.today <= challenge.end_date
          challenge.update(status: 'Started')
        elsif Date.today > challenge.end_date
          challenge.update(status: 'Failed')
        end
      end
    end
  end
end

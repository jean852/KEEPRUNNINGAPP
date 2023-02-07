class UpdateChallengeStatus
  include Sidekiq::Worker
  require 'date'

 # def perform
 #   challenges = Challenge.all
 #   challenges.each do |challenge|
 #     if challenge.challenge_type == "KM" && challenge.target_distance <= challenge.type_dependant_km
 #       challenge.update(status: 'Completed')
 #     elsif challenge.challenge_type == "Sessions" && challenge.target_sessions <= challenge.type_dependant_sessions
 #       challenge.update(status: 'Completed')
 #     elsif challenge.status == 'Not started'
 #       if Date.today >= challenge.start_date && Date.today <= challenge.end_date
 #         challenge.update(status: 'Started')
 #       elsif Date.today > challenge.end_date
 #         challenge.update(status: 'Failed')
 #       end
 #     end
 #   end
 # end

#  def perform
#    challenges = Challenge.all
#    if challenge.status == 'Not started' || challenge.status == "Started"
#      challenges.each do |challenge|
#        challenge.update(status: challenge.live_status)
#      end
#    end
#  end
end

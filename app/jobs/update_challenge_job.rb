class UpdateChallengeJob < ApplicationJob
  queue_as :default

  def perform(challenge)
    if (challenge.challenge_type == "KM" && challenge.target_distance <= challenge.type_dependant_km) || (challenge.challenge_type == "Sessions" && challenge.target_sessions <= challenge.type_dependant_sessions)
      return 'Completed'
    elsif Date.today >= challenge.start_date && Date.today <= challenge.end_date
      return 'Started'
    elsif Date.today > challenge.end_date
      return 'Failed'
    else
      return "Not started"
    end
  end
end

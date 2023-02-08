namespace :challenge_status do
  desc "Updates once a day the challenge status to trigger reimbursement"
  task update_status: :environment do
    challenges = Challenge.all
    puts "Updating #{challenges.size} challenges"
    challenges.each do |challenge|
      UpdateChallengeJob.perform_later(challenge)
      puts "Challenge updated. New status #{challenge.status}"
    end
  end
end

class UpdateChallengeStatus
  include Sidekiq::Worker
  require 'date'

  def perform
    challenges = Challenge.all
    challenges.each do |challenge|
     # challenge.update(name: 'Test')
      if challenge.status == 'PENDING'
        if Date.today >= challenge.start_date && Date.today <= challenge.end_date
          challenge.update(status: 'Started')
        elsif Date.today > challenge.end_date
          challenge.update(status: 'Failed')
        end
      end
    end
  end
end

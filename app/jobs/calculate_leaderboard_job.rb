class CalculateLeaderboardJob < ApplicationJob
  queue_as :default

  def perform challenge
    start_time = Time.parse '2015-08-01'
    end_time = Time.parse '2015-08-20'
    calculator = ChallengeCalculatorService.new challenge, start_time, end_time
    calculator.calculate!
  end
end

class CalculateLeaderboardJob < ApplicationJob
  queue_as :default

  def perform challenge
    calculator = ChallengeCalculatorService.new challenge, challenge.created_at, challenge.end_time
    calculator.calculate!
  end
end

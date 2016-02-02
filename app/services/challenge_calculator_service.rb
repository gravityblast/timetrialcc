class ChallengeCalculatorService
  attr_reader :challenge, :start_time, :end_time

  def initialize challenge, start_time, end_time
    @challenge  = challenge
    @start_time = start_time
    @end_time   = end_time
  end

  def calculate!
    leaderboard = timetrial.leaderboard tt_users
    update_challenge! leaderboard
  end

  def tt_users
    users = challenge.users.map do |user|
      StravaTT::User.new user.id, user.access_token
    end
  end

  private

  def update_challenge! leaderboard
    leaderboard.each do |result|
      uc = UserChallenge.joins(:challenge).where('user_challenges.user_id = ? AND challenges.segment_id = ?', result[:user_id], challenge.segment_id).first
      uc.update! moving_time: result[:effort].moving_time if uc
    end
    challenge.calculated!
  end

  def timetrial
    @timetrial ||= StravaTT.new challenge.segment_id, start_time, end_time
  end
end

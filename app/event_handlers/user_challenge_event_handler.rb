class UserChallengeEventHandler < BaseEventHandler
  def created
    return if !user || !challenge

    data = {
      event:      event,
      subject:    challenge,
      originator: user,
    }

    challenge.users.order('user_challenges.created_at ASC').each do |recipient|
      create_activity data.merge(recipient: recipient)
    end
  end

  private

  def user
    @user ||= User.find_by id: event.data['user_id']
  end

  def challenge
    @challenge ||= Challenge.find_by id: event.data['challenge_id']
  end
end


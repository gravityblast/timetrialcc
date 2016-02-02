class ChallengeEventHandler < BaseEventHandler
  def updated
    return unless challenge
    return unless event.data['calculated']

    data = {
      event:      event,
      subject:    challenge,
      originator: challenge,
    }

    challenge.users.each do |recipient|
      create_activity data.merge(recipient: recipient)
    end
  end

  private

  def challenge
    @challenge ||= Challenge.find_by id: event.data['id']
  end
end


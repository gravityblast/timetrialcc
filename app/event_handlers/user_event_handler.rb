class UserEventHandler < BaseEventHandler
  def created
    return unless user

    data = {
      event:      event,
      subject:    user,
      originator: user,
      recipient:  user
    }

    create_activity data
  end

  private

  def user
    @user ||= User.find_by id: event.data['id']
  end
end

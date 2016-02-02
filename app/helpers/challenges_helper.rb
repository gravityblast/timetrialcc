module ChallengesHelper
  def formatted_moving_time total_seconds
    total_seconds = total_seconds.to_i
    return '--:--:--' if total_seconds < 1

    seconds = total_seconds % 60
    minutes = (total_seconds / 60) % 60
    hours = total_seconds / (60 * 60)

    format '%02d:%02d:%02d', hours, minutes, seconds
  end
end

class HomeController < ApplicationController
  skip_before_action :authenticate_strava_user!, only: :landing

  def landing
    if current_user
      redirect_to  home_path
    end
  end

  def show
    @challenges = current_user.challenges
  end
end

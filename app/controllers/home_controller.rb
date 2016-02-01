class HomeController < ApplicationController
  skip_before_action :authenticate_strava_user!, only: :landing

  def landing
    if current_user
      redirect_to  home_path
    end
  end

  def show
    @challenges = current_user.challenges
    @activities = current_user.
                    inbound_activities.
                    page(params[:page]).
                    per(30).
                    order('event_created_at DESC').
                    includes(:originator)
  end
end

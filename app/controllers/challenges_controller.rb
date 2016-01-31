class ChallengesController < ApplicationController
  skip_before_action :authenticate_strava_user!, only: :show

  def new
    @challenge = current_user.challenges.build
  end

  def show
    @challenge = Challenge.find params[:id]
  end
end

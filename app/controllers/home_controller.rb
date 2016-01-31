class HomeController < ApplicationController
  skip_before_action :authenticate_strava_user!, only: :landing

  def landing
  end

  def show
  end
end

class ChallengesController < ApplicationController
  skip_before_action :authenticate_strava_user!, only: :show

  def new
    attrs = {
      segment_id: params[:sid],
      segment_name: params[:sname],
      segment_polyline: params[:spl],
      segment_start_latlng: params[:ssll],
      segment_end_latlng: params[:sell]
    }

    @challenge = current_user.challenges.build attrs
  end

  def new_from_segment
    if params[:sid].blank?
      redirect_to new_challenge_path
      return
    end

    client = current_user.strava_client
    segment = client.segment params[:sid]

    redirect_to new_challenge_path({
      sid: segment.id,
      sname: segment.name,
      spl: segment.map.try(:polyline),
      ssll: segment.start_latlng.join(','),
      sell: segment.end_latlng.join(',')
    })
  rescue MiniStrava::Client::ResourceNotFound
    redirect_to new_challenge_path
  end

  def create
    attrs = challenge_params.to_h
    attrs[:end_time] = Time.at attrs[:end_time].to_i
    @challenge = current_user.owned_challenges.build attrs
    if @challenge.save
      @challenge.users << current_user
      CalculateLeaderboardJob.set(wait_until: @challenge.end_time).perform_later @challenge
      flash_message :success, 'Challenge created successfully. Ask your friends to join!'
      redirect_to challenge_path(@challenge)
    else
      render :new
    end
  end

  def show
    @challenge = Challenge.find(params[:id])
    order = if @challenge.calculated?
      'user_challenges.moving_time ASC NULLS LAST'
    else
      'user_challenges.created_at ASC'
    end
    @user_challenges = @challenge.user_challenges.includes(:user).order(order)
  end

  def search_segments
    client = current_user.strava_client
    bounds = params[:bounds].to_s.split ','
    if valid_bounds? bounds
      @segments = client.search_segments bounds
    else
      @segments = []
    end

    render layout: false
  end

  def join
    challenge = Challenge.find params[:id]
    current_user.join challenge
    flash_message :success, 'You joined this challenge'
  rescue Challenge::ChallengeAlreadyFullException
    flash_message :warning, 'Challenge is already full'
  ensure
    redirect_to challenge_path(challenge)
  end

  private

  def valid_bounds? bounds
    bounds.to_a.size == 4 && bounds.to_a.find{|i| i.blank?}.nil?
  end

  def challenge_params
    params.require(:challenge).permit([
      :segment_id,
      :segment_name,
      :segment_polyline,
      :segment_start_latlng,
      :segment_end_latlng,
      :name,
      :end_time,
    ])
  end
end

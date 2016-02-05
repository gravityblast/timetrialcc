class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  skip_before_action :authenticate_strava_user!
  skip_before_action :redirect_to_previous_attempted_url

  def strava
    user, is_new_user = User.from_omniauth request.env['omniauth.auth']
    event_action = is_new_user ? :signup : :login
    track_event category: :user, action: event_action, label: user.id

    if user.persisted?
      sign_in_and_redirect user, event: :authentication
      if is_navigational_format?
        flash_message :notice, 'Successfully authenticated from Strava account.'
      end
    else
      session['devise.strava'] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end

  def failure
    redirect_to root_path
  end
end

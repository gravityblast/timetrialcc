require 'rails_helper'

RSpec.describe ChallengesController, :type => :controller do
  describe 'GET new' do
    context 'anonymous user' do
      it 'redirects to login' do
        get :new
        expect(response).to redirect_to(user_omniauth_authorize_path(provider: :strava))
      end
    end

    context 'anonymous user' do
      it 'returns a 200 status code' do
        sign_in Fabricate(:user)
        get :new
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe 'GET show' do
    describe 'valid challenge ID' do
      it 'returns http success' do
        challenge = Fabricate :challenge
        get :show, params: { id: challenge.id }
        expect(response).to have_http_status(:success)
      end
    end

    describe 'challenge not found' do
      it 'returns http not found' do
        expect do
          get :show, params: { id: 'xyz' }
        end.to raise_error(ActiveRecord::RecordNotFound)
      end
    end
  end

  describe 'PUT join' do
    context 'user has not joined yet the challenge' do
      it 'adds user to the challenge' do
        challenge = Fabricate :challenge
        user = Fabricate :user
        sign_in user

        put :join, params: { id: challenge }

        expect(user.challenges).to eq([challenge])
      end
    end
  end
end

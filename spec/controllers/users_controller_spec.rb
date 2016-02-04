require 'rails_helper'

RSpec.describe UsersController, :type => :controller do
  describe 'GET settings' do
    it 'return a 200 reponse' do
      sign_in Fabricate(:user)
      get :settings
      expect(response).to be_success
    end
  end

  describe 'DELETE destroy' do
    it 'destroy user' do
      user = Fabricate(:user)
      sign_in user
      delete :destroy
      expect do
        user.reload
      end.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end


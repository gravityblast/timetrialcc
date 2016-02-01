require 'rails_helper'

RSpec.describe User, type: :model do
  describe '#join' do
    context 'valid challenge' do
      it 'calls challenge.add' do
        challenge = Fabricate :challenge
        user = Fabricate :user

        expect(challenge).to receive(:add).with(user)
        user.join challenge
      end
    end

    context 'invalid challenge type' do
      it 'calls challenge.add' do
        user = Fabricate :user
        expect do
          user.join :foo
        end.to raise_error(TypeError)
      end
    end
  end

  describe 'events' do
    context 'after creating a new user' do
      it 'creates an event' do
        expect do
          Fabricate :user
        end.to change(Event, :count).by(1)
      end
    end
  end
end

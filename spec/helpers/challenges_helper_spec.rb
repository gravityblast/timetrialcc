require 'rails_helper'

RSpec.describe ChallengesHelper, type: :helper do
  describe '#formatted_moving_time' do
    context 'blank value' do
      it 'return string without times' do
        expect(helper.formatted_moving_time nil).to eq('--:--:--')
      end
    end

    context 'passing valid seconds' do
      it 'return a string with hours, minutes, and seconds' do
        expect(helper.formatted_moving_time 86462).to eq('24:01:02')
      end
    end
  end
end

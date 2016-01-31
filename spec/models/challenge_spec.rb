require 'rails_helper'

RSpec.describe Challenge, type: :model do
  describe 'validations' do
    it 'requires a user' do
      c = Fabricate :challenge
      expect(c).to be_valid

      c.user = nil
      expect(c.valid?).to eq(false)
      expect(c.errors['user']).to be_present
    end

    it 'requires a name' do
      c = Fabricate :challenge
      expect(c).to be_valid

      c.name = nil
      expect(c.valid?).to eq(false)
      expect(c.errors['name']).to be_present
    end

    it 'requires a segment_id' do
      c = Fabricate :challenge
      expect(c).to be_valid

      c.segment_id = nil
      expect(c.valid?).to eq(false)
      expect(c.errors['segment_id']).to be_present
    end

    it 'requires a segment_name' do
      c = Fabricate :challenge
      expect(c).to be_valid

      c.segment_name = nil
      expect(c.valid?).to eq(false)
      expect(c.errors['segment_name']).to be_present
    end

    it 'requires a end_time' do
      c = Fabricate :challenge
      expect(c).to be_valid

      c.end_time = nil
      expect(c.valid?).to eq(false)
      expect(c.errors['end_time']).to be_present
    end
  end
end

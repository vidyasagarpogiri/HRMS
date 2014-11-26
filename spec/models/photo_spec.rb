require 'rails_helper'

RSpec.describe Photo, type: 'model' do
  describe 'checking Photo Model level Validation' do
    it 'creating photo valid with valid details' do
      expect(FactoryGirl.create(:photo)).to be_valid
    end

    it 'invalid witout album_id' do
      expect(FactoryGirl.build(:photo, album_id: nil, image: 'qqq')).to_not be_valid
    end

    it 'invalid witout image' do
      expect(FactoryGirl.build(:photo, album_id: 1, image: nil)).to_not be_valid
    end

    it 'invalid witout image and album_id' do
      expect(FactoryGirl.build(:photo, album_id: nil, image: nil)).to_not be_valid
    end
  end
end

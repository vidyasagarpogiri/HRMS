require 'rails_helper'

RSpec.describe Album, type: 'model' do
  describe 'Checking Album Model Level Validattions' do

    it 'Create Albums With Valid Deatils' do
      expect(FactoryGirl.create(:album)).to be_valid
    end

    it 'Is invalid without attributes' do
      expect(FactoryGirl.build(:album, title: nil, description: nil, employee_id: nil, likes_count: 3)).to_not be_valid
    end

    it 'Is invalid without title' do
      expect(FactoryGirl.build(:album, title: nil, description: 'qqq', employee_id: 1, likes_count: 1)).to_not be_valid
    end

    it 'Is invalid without Description' do
      expect(FactoryGirl.build(:album, title: 'Album', description: nil, employee_id: 1, likes_count: 2)).to_not be_valid
    end

    it 'Is invalid without id' do
      expect(FactoryGirl.build(:album, title: 'Album', description: 'qqq', employee_id: nil, likes_count: 1)).to_not be_valid
    end
    
    it 'Is valid likes_count id' do
      expect(FactoryGirl.build(:album, title: 'Album', description: 'qqq', employee_id: nil, likes_count: nil)).to_not be_valid
    end
    
    it "Is invalid without any field" do
      expect(FactoryGirl.build(:album, title: nil ,description: nil, employee_id: nil, likes_count: nil)).to_not be_valid
    end
    
  end
end

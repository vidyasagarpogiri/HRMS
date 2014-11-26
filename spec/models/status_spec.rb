require 'rails_helper'

RSpec.describe Status, :type => :model do
 
  describe "Checking Statuses validations" do
    
    it "Create Status With Valid Attributes" do
      expect(FactoryGirl.create(:status)).to be_valid
    end
    
    it "Is invalid without status" do
      expect(FactoryGirl.build(:status, status: nil)).to_not be_valid
    end
    
    it "Is valid without likes count" do
      expect(FactoryGirl.build(:status, status: "hello this is status", likes_count: nil)).to be_valid
    end
    
     it "Is invalid without status" do
      expect(FactoryGirl.build(:status, status: nil, likes_count: '10')).to_not be_valid
    end
    
   end
end

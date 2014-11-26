require 'rails_helper'

RSpec.describe Status, :type => :model do
 
  describe "Checking Statuses validations" do
    
    it "Create Status With Valid Attributes" do
      expect(FactoryGirl.create(:status)).to be_valid
    end
    
    it "Is invalid without status " do
      expect(FactoryGirl.build(:status, status: nil, employee_id: 1, likes_count: nil)).to_not be_valid
    end
    
    it "Is invalid without employee" do
      expect(FactoryGirl.build(:status, status: "test", employee_id: nil, likes_count: 5)).to_not be_valid
    end
    
    
    it "Is valid without likes count" do
      expect(FactoryGirl.build(:status, status: "hello this is status", likes_count: nil)).to be_valid
    end
    
     it "Is valid with status and likescount" do
      expect(FactoryGirl.build(:status, status: "hiii", likes_count: '0')).to be_valid
    end
    
    it "Is invalid with status and without emp and likescount" do
      expect(FactoryGirl.build(:status, status: "hiii", employee_id: nil, likes_count: nil)).to_not be_valid
    end
    
    it "Is invalid without status, emp and likescount" do
      expect(FactoryGirl.build(:status, status: nil , employee_id: nil, likes_count: nil)).to_not be_valid
    end
    
     it "Is invalid without any field in status" do
      expect(FactoryGirl.build(:status, status: nil , employee_id: nil, likes_count: nil)).to_not be_valid
    end
    
   end
end

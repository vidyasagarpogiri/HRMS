require 'rails_helper'

RSpec.describe Like, :type => :model do

  describe "Checking Likes validations" do
    
    it "Create Like With Valid Attributes" do
      expect(FactoryGirl.create(:like)).to be_valid
    end
  
    it "Is invalid without status_id " do
      expect(FactoryGirl.build(:like, status_id: nil, employee_id: 1)).to_not be_valid
    end
     
    it "Is invalid without status_id,employee" do
      expect(FactoryGirl.build(:like, status_id: nil, employee_id: nil)).to_not be_valid
    end
    
    it "Is invalid without employee" do
      expect(FactoryGirl.build(:like, status_id: 1, employee_id: nil)).to_not be_valid
    end
    
    it "Is invalid without any fileds" do
      expect(FactoryGirl.build(:like, status_id: nil, employee_id: nil)).to_not be_valid
    end
   
end
end

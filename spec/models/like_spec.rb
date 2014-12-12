require 'rails_helper'

RSpec.describe Like, :type => :model do

  describe "Checking Likes validations" do
    
    it "Create Like With Valid Attributes" do
      expect(FactoryGirl.create(:like,likeable_id: 1, likeable_type: "status", is_like: true, employee_id: 1)).to be_valid
    end
  
    it "Is invalid with in-valid attributes " do
      expect(FactoryGirl.build(:like,likeable_id: 1, likeable_type: "status", is_like: nil, employee_id: nil)).to_not be_valid
    end
     
    it "Is invalid without employee" do
      expect(FactoryGirl.build(:like,likeable_id: 1, likeable_type: "status", is_like: true, employee_id: nil)).to_not be_valid
    end
    
    it "Is invalid without like" do
      expect(FactoryGirl.build(:like,likeable_id: nil, likeable_type: "status", is_like: nil, employee_id: 1)).to_not be_valid
    end
    
    it "Is invalid without any fileds" do
      expect(FactoryGirl.build(:like,likeable_id: nil, likeable_type: nil, is_like: nil, employee_id: nil)).to_not be_valid
    end
   
end
end




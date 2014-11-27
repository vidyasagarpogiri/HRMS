require 'rails_helper'

RSpec.describe Comment, :type => :model do
   
  describe "Checking Comments validations" do
    
    it "Create Comments With Valid Attributes" do
      expect(FactoryGirl.create(:comment)).to be_valid
    end
   
    it "Is invalid without status_id " do
      expect(FactoryGirl.build(:comment, status_id: nil, comment: "hello", employee_id: 1)).to_not be_valid
    end
     
    it "Is invalid without status_id,employee" do
      expect(FactoryGirl.build(:comment, status_id: nil, comment: "hello", employee_id: nil)).to_not be_valid
    end
    
    it "Is invalid without employee" do
      expect(FactoryGirl.build(:comment, status_id: 1, comment: "hello", employee_id: nil)).to_not be_valid
    end
    
    it "Is invalid without any fileds" do
      expect(FactoryGirl.build(:comment, status_id: nil, comment: nil, employee_id: nil)).to_not be_valid
    end
   
    it "Is invalid without comment" do
      expect(FactoryGirl.build(:comment, status_id: 1, comment: nil, employee_id: 1)).to_not be_valid
    end
   
   it "Is invalid without status_id and comment" do
      expect(FactoryGirl.build(:comment, status_id: nil, comment: nil, employee_id: 1)).to_not be_valid
    end
    
end
end

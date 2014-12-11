require 'rails_helper'

RSpec.describe Comment, :type => :model do
   
  describe "Checking Comments validations" do
    
    it "Create Comments With Valid Attributes" do
      expect(FactoryGirl.create(:comment, comment: "test",commentable_id: 1,commentable_type: "status", employee_id: 1)).to be_valid
    end
    
     it "Is invalid without comment " do
      expect(FactoryGirl.build(:comment,  comment: nil,commentable_id: 1, commentable_type: "status", employee_id: 1)).to_not be_valid
    end
    
    it "Is invalid without commentable_id " do
      expect(FactoryGirl.build(:comment,  comment: "test",commentable_id: nil, commentable_type: "status", employee_id: 1)).to_not be_valid
    end
    
    it "Is invalid without commentable_type" do
      expect(FactoryGirl.build(:comment,  commentable_id: 1, commentable_type: nil, employee_id: 1)).to_not be_valid
    end
    
    it "Is invalid without employee" do
      expect(FactoryGirl.build(:comment,  commentable_id: 1, commentable_type: "status", employee_id: nil)).to_not be_valid
    end
    
    it "Is invalid without any fileds" do
      expect(FactoryGirl.build(:comment,  comment: "test",commentable_id: nil, commentable_type: nil, employee_id: nil)).to_not be_valid
    end
   
    it "Is invalid without comment,employee" do
      expect(FactoryGirl.build(:comment, comment: nil,commentable_id: 1, commentable_type: "status", employee_id: nil)).to_not be_valid
    end
   
   it "Is invalid without employee and commentable_id" do
      expect(FactoryGirl.build(:comment, comment: "test",commentable_id: nil, commentable_type: "status", employee_id: nil)).to_not be_valid
    end
    
   it "Is invalid with blank comment or empty comment" do
      expect(FactoryGirl.build(:comment, comment: nil ,commentable_id: "status", commentable_type: "status", employee_id: 1)).to_not be_valid
    end
    
end
end


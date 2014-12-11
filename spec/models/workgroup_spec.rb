require 'rails_helper'

RSpec.describe Workgroup, :type => :model do

  describe "Checking Workgroup validations" do
    
    it "Create Workgroups With Valid Attributes" do
      expect(FactoryGirl.create(:workgroup, name: "test",description: "testing",admin_id: 1)).to be_valid
    end
    
    it "Is invalid With Invalid attributes " do
      expect(FactoryGirl.build(:workgroup, name: nil,description: nil,admin_id: nil)).to_not be_valid
    end
    
    it "Is invalid without workgroup name " do
      expect(FactoryGirl.build(:workgroup, name: nil,description: "MyText",admin_id: 1)).to_not be_valid
    end
   
    it "Is invalid without employee" do
      expect(FactoryGirl.build(:workgroup, name: "test",description: "MyText",admin_id: nil)).to_not be_valid
    end
    
    it "Is invalid without description" do
      expect(FactoryGirl.build(:workgroup, name: "test",description: nil,admin_id: 1)).to_not be_valid
    end
    
    it "Is invalid without any field in workgroups" do
      expect(FactoryGirl.build(:workgroup, name: nil , description: nil,admin_id: nil)).to_not be_valid
    end
    
  end
end



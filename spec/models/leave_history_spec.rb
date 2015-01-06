require 'rails_helper'

RSpec.describe LeaveHistory, :type => :model do
  before(:each) do
    @employee =  FactoryGirl.create(:employee) 
    FactoryGirl.create(:leave_history, employee_id: @employee.id)
  end
  
  describe "Checking Leaves validations" do
    
    it "Apply float leave With Valid Attributes" do
      expect(FactoryGirl.create(:leave_history, from_date: "30/01/2015",to_date: "30/01/2015",leave_type_id: 2,employee_id: 1)).to be_valid
    end
    
    it "Is invalid With Invalid attributes " do
      expect(FactoryGirl.build(:leave_history, from_date: nil ,to_date: nil,leave_type_id: nil ,employee_id: nil)).to_not be_valid
    end
  
    it "Is invalid without employee " do
      expect(FactoryGirl.build(:leave_history, from_date:"30/01/2015" ,to_date:"30/01/2015",leave_type_id: 2 ,employee_id: nil)).to_not be_valid
    end
   
    it "Is invalid without leavetype" do
      expect(FactoryGirl.build(:leave_history, from_date:"30/01/2015" ,to_date:"30/01/2015",leave_type_id: nil ,employee_id: 1)).to_not be_valid
    end
    
    it "Is invalid without date" do
      expect(FactoryGirl.build(:leave_history, from_date: nil ,to_date: nil,leave_type_id: nil ,employee_id: 1)).to_not be_valid
    end

 end  
end


require 'rails_helper'

RSpec.describe LeaveHistoriesController, :type => :controller do
	 before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      employee = FactoryGirl.create(:employee)
      user = employee.user
      sign_in user
    end


 let(:valid_leavehistory_attributes) {
    {from_date:"30/01/2015" , to_date: "30/01/2015",leave_type_id: 2, employee_id: 1 }
  }

  let(:invalid_leavehistory_attributes) {
     {from_date: nil , to_date: nil ,leave_type_id: 2, employee_id: 1 }
  }
  
  let(:valid_member_workgroup_attributes) {
    {}
  }
  
   describe " workgroups # GET" do
    it "assigns all leaves as @leavehistory " do
      leave = LeaveHistory.create!(valid_leavehistory_attributes)
      #leave1 = LeaveHistory.create!(valid_leavehistory_attributes)
      get :index, {}
      expect(assigns(:leavehistories)).to eq(leave)
    end  
   end
   
   
   
   

end

# LeaveHistory(id: integer, from_date: string, to_date: string, reason: text, feedback: text, leave_type_id: integer, employee_id: integer, created_at: datetime, updated_at: datetime, status: string, subject: string, is_halfday: boolean, days: float, section: string) 

#Date	No.of Days	Reason	Leave Type	Status	Action
#20 Jan, 2015 - 20 Jan, 2015	1.0 day	hai	Floating Holiday	HOLD	Edit Delete


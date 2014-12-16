require 'rails_helper'

RSpec.describe AppraisalsController, :type => :controller do
     before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      employee = FactoryGirl.create(:employee)
      user = employee.user
      sign_in user
    end
    
    test "it populates array of appraisal templares" do
      appraisal_template1 = FactotyGirl.create(:appraisal)
      appraisal_template1 = FactotyGirl.create(:appraisal)
      appraisal_template1 = FactotyGirl.create(:appraisal)
    end
end

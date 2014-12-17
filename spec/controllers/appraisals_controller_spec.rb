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
    
    describe "GET #new" do
      it "redirect to new page " do
        xhr :get, :new, {}
        expect(assigns(:appraisal)).to be_a_new(Appraisal)
      end
    end
end

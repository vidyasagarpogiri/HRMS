require 'rails_helper'

RSpec.describe AppraisalCyclesController, :type => :controller do
  
   before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      employee = FactoryGirl.create(:employee)
      user = employee.user
      sign_in user
    end
  
  describe "GET #index" do 
  	it "populates an array of recruitments" do
    	appraisal_cycle1 = FactoryGirl.create(:appraisal_cycle) 
      appraisal_cycle2 = FactoryGirl.create(:appraisal_cycle) 
      appraisal_cycle3 = FactoryGirl.create(:appraisal_cycle) 
      get :index, {}
      expect(assigns(:appraisal_cycles)).to eq([appraisal_cycle1, appraisal_cycle2, appraisal_cycle3]) 
    end
	end

  describe "GET #new" do
    it "redirect to new page " do
      get :new, {}
      expect(assigns(:appraisal_cycle)).to be_a_new(AppraisalCycle)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "When we create a new record" do
        expect{ post :create, appraisal_cycle: FactoryGirl.attributes_for(:appraisal_cycle)}.to change(AppraisalCycle,:count).by(1) 
      end
      it "After create redirect to index page" do
        post :create, appraisal_cycle: FactoryGirl.attributes_for(:appraisal_cycle)
        expect(response).to redirect_to(appraisal_cycles_path) 
      end
    end
    context "with invalid attributes" do
        it "re-renders the 'new' template" do 
          post :create, appraisal_cycle: {title: "eTeki12", start_date: nil,  end_date: nil, period: nil, employee_dead_line: nil, manager_dead_line: nil, discussion_dead_line: nil, status: nil, department_id: nil }
          expect(response).to render_template('new')
        end
    end

  end

end

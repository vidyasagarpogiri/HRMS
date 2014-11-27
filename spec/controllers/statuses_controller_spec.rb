require 'rails_helper'

RSpec.describe StatusesController, :type => :controller do

  before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      employee = FactoryGirl.create(:employee)
      user = employee.user
      sign_in user
    end
    
    
let(:valid_status_attributes) {
    {status: "Hello New Status", employee_id: 1 }
  }

  let(:invalid_status_attributes) {
    {status: nil, employee_id: 1}
  }

  describe "GET index" do
    it "assigns all statuses as @statuses" do
      status = Status.create!(valid_status_attributes)
      status1 = Status.create!(valid_status_attributes)
      get :index, {}
      expect(assigns(:statuses)).to eq([status, status1])
    end
     
  end

 describe "GET #new" do
    it "writing a new  status to @new_status with valid attibutes" do 
      get :new, {}
      expect(assigns(:status)).to be_a_new(Status)
    end
  end
 
 describe "POST #create" do 
    context "Create status  with valid attributes" do
      it "creates a new status" do
        expect {
          post :create, {status:  FactoryGirl.attributes_for(:status)}
        }.to change(Status, :count).by(1)
      end 
      
      it "redirects to the status create" do
         post :create, {status:  FactoryGirl.attributes_for(:status)}
         expect(response).to redirect_to(statuses_path)
      end
    end
    end
  
 
  describe "POST #Create" do
    before :each do
     @status = FactoryGirl.attributes_for(:status, status: "helllooo", employee_id: 1) 
     @status  = FactoryGirl.create(:status)
    end
    end
  
  describe "DESTORY delete" do 
    before(:each) do
       @status  = FactoryGirl.create(:status)
    end

    it "destroys the requested status " do 
      expect{ delete :destroy, {id: @status}}.to change(Status, :count).by(-1)
    end
  end
   

end












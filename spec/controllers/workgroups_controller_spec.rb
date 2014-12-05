require 'rails_helper'

RSpec.describe WorkgroupsController, :type => :controller do

 before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      employee = FactoryGirl.create(:employee)
      user = employee.user
      sign_in user
    end

 let(:valid_workgroup_attributes) {
    {name: "Hai", description:"hello", admin_id: 1 }
  }

  let(:invalid_workgroup_attributes) {
    {status: nil, description:"hello", admin_id: 1}
  }
  
  
   describe "GET # Index" do
    it "assigns all workgroups as @workgroups" do
      workgroup = Workgroup.create!(valid_workgroup_attributes)
      workgroup1 = Workgroup.create!(valid_workgroup_attributes)
      get :index, {}
      expect(assigns(:workgroups)).to eq([workgroup, workgroup1])
    end  
   end
   
    describe "GET # New" do
    it "creating new workgroup with valid attibutes" do 
      get :new, {}
      expect(assigns(:workgroup)).to be_a_new(Workgroup)
    end
  end
  
   describe "POST # Create" do 
    context "Create workgroup  with valid attributes" do
      it "creates a new workgroup" do
        expect {
          post :create, {workgroup:  FactoryGirl.attributes_for(:workgroup)}
        }.to change(Workgroup, :count).by(1)
      end 
      
      it "redirects to the workgroups index" do
         post :create, {workgroup:  FactoryGirl.attributes_for(:workgroup)}
         expect(response).to redirect_to(workgroups_path)
      end
    end
    end
  
  describe "POST # Create" do 
    context "Create workgroup  with invalid attributes" do
      it "creates a new workgroup" do
        expect {
          post :create, {workgroup:  FactoryGirl.attributes_for(:workgroup)}
        }.to change(Workgroup, :count).by(1)
      end 
      
      it "renders the workgroup new page" do
         post :create, {workgroup:  FactoryGirl.attributes_for(:workgroup)}
         expect(response).to redirect_to(workgroups_path)
      end
    end
    end
    
     describe "DELETE # Destroy" do 
    before(:each) do
       @workgroup = FactoryGirl.create(:workgroup)
    end

    it "destroys the selected workgroup " do 
      expect{ delete :destroy, {id: @workgroup}}.to change(Workgroup, :count).by(-1)
    end
  end
  
  
end

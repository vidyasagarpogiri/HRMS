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
    {name: nil, description:"hello", admin_id: 1}
  }
  
  let(:valid_member_workgroup_attributes) {
    {}
  }
  
   describe " workgroups # GET" do
    it "assigns all workgroups as @workgroups" do
      workgroup = Workgroup.create!(valid_workgroup_attributes)
      workgroup1 = Workgroup.create!(valid_workgroup_attributes)
      get :index, {}
      expect(assigns(:workgroups)).to eq([workgroup, workgroup1])
    end  
   end
   
    describe "new_workgroup # GET" do
    it "creating new workgroup with valid attibutes" do 
      get :new, {}
      expect(assigns(:workgroup)).to be_a_new(Workgroup)
    end
  end
  
   describe "POST # Create new_workgroup " do 
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
  
  describe "POST # Create new_workgroup" do 
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
    
     describe "DELETE # Destroy workgroup" do 
    before(:each) do
       @workgroup = FactoryGirl.create(:workgroup)
    end

    it "destroys the selected workgroup " do 
      expect{ delete :destroy, {id: @workgroup}}.to change(Workgroup, :count).by(-1)
    end
  end
  
  
  describe "PUT # workgroups update " do
    before :each do
     @updated_workgroup = FactoryGirl.attributes_for(:workgroup, name: "Development") 
     @workgroup  = FactoryGirl.create(:workgroup)
     @invalid_workgroup = FactoryGirl.attributes_for(:workgroup, description: nil) 
    end 
    context "with valid attributes" do
      it "changes @workgroup's attributes" do
        
        put :update, {id: @workgroup, workgroup: @updated_workgroup}
        expect(assigns(:workgroup)).to eq(@workgroup)
      end

      it "Redirects to index path" do
        
        put :update, {id: @workgroup, workgroup: @updated_workgroup}
        expect(response).to redirect_to(workgroups_path)
      end

      it "Redirects to index path" do
        put :update, {id: @workgroup, workgroup: @updated_workgroup}
        @workgroup.reload
        expect(@workgroup.name).to eq("Development")
      end
    end
     context "with invalid attributes" do
      it "does not change @workgroup's attributes" do 
        put :update, {id: @workgroup, workgroup: @invalid_workgroup}
        @workgroup.reload
        expect(@workgroup.description).to eq("MyText")
      end
      it "render to edit page" do 
        put :update, {id: @workgroup, workgroup: @invalid_workgroup}
        expect(response).to render_template("edit")
      end
     end
  end
 
 
  describe "add_member_workgroup # GET" do 
     let(:valid_member_workgroup_attributes) {
    {name: "ROR Team", description:"ROR", admin_id: 1}
    }
    context "Add members to workgroup" do
      it "creates a new workgroup" do
        expect {
          post :create, {workgroup:  FactoryGirl.attributes_for(:workgroup)}
        }.to change(Workgroup, :count).by(1)
      end 
      
      it "redirects to the workgroups index" do
         post :create, {workgroup:  FactoryGirl.attributes_for(:workgroup)}
         expect(response).to redirect_to(workgroups_path)
      end
      
      it "Adds the employee as member to the workgroup" do
      workgroup = Workgroup.create!(valid_workgroup_attributes) 
         get :add_members, {id: workgroup.id}    
      end 
    end
  end 

   describe "add_moderator_workgroup # GET" do 
     let(:valid_member_workgroup_attributes) {
    {name: "ROR Team", description:"ROR", admin_id: 1}
    }
    context "Add moderator to workgroup " do
      it "creates a new workgroup" do
        expect {
          post :create, {workgroup:  FactoryGirl.attributes_for(:workgroup)}
        }.to change(Workgroup, :count).by(1)
      end 
      
      it "redirects to the workgroups index" do
         post :create, {workgroup:  FactoryGirl.attributes_for(:workgroup)}
         expect(response).to redirect_to(workgroups_path)
      end
      
      it "Adds the employee as member to the workgroup" do
      workgroup = Workgroup.create!(valid_workgroup_attributes) 
         get :add_members, {id: workgroup.id}    
      end 
      it "Adds the member as moderator to the workgroup" do
      workgroup = Workgroup.create!(valid_workgroup_attributes) 
         get :add_moderator, {id: workgroup.id}    
      end 
    end
  end
  
  describe "destroy_member_workgroup # GET" do 
  
     let(:valid_member_workgroup_attributes) {
    {name: "ROR Team", description:"ROR", admin_id: 1}
    }
    
    context "Destroying member in workgroup" do
      it "creates a new workgroup" do
        expect {
          post :create, {workgroup:  FactoryGirl.attributes_for(:workgroup)}
        }.to change(Workgroup, :count).by(1)
      end 
      
      it "redirects to the workgroups index" do
         post :create, {workgroup:  FactoryGirl.attributes_for(:workgroup)}
         expect(response).to redirect_to(workgroups_path)
      end
      
      it "Adds the employee as member to the workgroup" do
      workgroup = Workgroup.create!(valid_workgroup_attributes) 
         get :add_members, {id: workgroup.id}    
      end 
      
      it "destroys the requested member" do 
      expect{ delete :destroy_member, {id: employee_id}}
      end    
    end 
 end
  
  describe "destroy_moderator_workgroup # GET" do 
  
     let(:valid_member_workgroup_attributes) {
    {name: "ROR Team", description:"ROR", admin_id: 1}
    }
    
    context "Destroying moderator in workgroup" do
      it "creates a new workgroup" do
        expect {
          post :create, {workgroup:  FactoryGirl.attributes_for(:workgroup)}
        }.to change(Workgroup, :count).by(1)
      end 
      
      it "redirects to the workgroups index" do
         post :create, {workgroup:  FactoryGirl.attributes_for(:workgroup)}
         expect(response).to redirect_to(workgroups_path)
      end
      
      it "Adds the employee as member to the workgroup" do
      workgroup = Workgroup.create!(valid_workgroup_attributes) 
         get :add_members, {id: workgroup.id}    
      end 
      
      it "destroys the requested moderator" do 
      expect{ delete :destroy_member, {id: employee_id}}
      end    
    end 
 end

  
end







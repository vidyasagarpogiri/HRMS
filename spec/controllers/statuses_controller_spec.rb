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
  let(:valid_like_attributes){
    {is_like: true, employee_id: 1, status_id: 1}
    }
 
 
  let(:status){
  {status: FactoryGirl.attributes_for(:status)}  
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
      
      it "redirects to the statuses index" do
         post :create, {status:  FactoryGirl.attributes_for(:status)}
         expect(response).to redirect_to(statuses_path)
      end
    end
    end
  
   describe "POST #create" do 
    context "Create status  with invalid attributes" do
      it "creates a new status" do
        expect {
          post :create, {status:  FactoryGirl.attributes_for(:status)}
        }.to change(Status, :count).by(1)
      end 
      
      it "renders the status new page" do
         post :create, {status:  FactoryGirl.attributes_for(:status)}
         expect(response).to redirect_to(statuses_path)
      end
    end
    end
  
  describe "GET index# show" do
    it "assigns all statuses as @statuses" do
      status = Status.create!(valid_status_attributes)
      status1 = Status.create!(valid_status_attributes)
      get :index, {}
      expect(assigns(:statuses)).to eq([status, status1])
    end
    it "show one status" do
      status = FactoryGirl.create(:status)
      get :show, id:status.id
      expect(assigns(:status)).to eq(status)  
    end
   end
   
  
  describe "POST #Create" do
    before :each do
     @status = FactoryGirl.attributes_for(:status, status: "helllooo", employee_id: 1) 
     @status  = FactoryGirl.create(:status)
    end
    end
  
  describe "DELETE # Destroy" do 
    before(:each) do
       @status  = FactoryGirl.create(:status)
    end

    it "destroys the requested status " do 
      expect{ delete :destroy, {id: @status}}.to change(Status, :count).by(-1)
    end
  end
  
   describe "POST #create like" do 
    context "Add like  status  with valid attributes" do
      it "creates a new status" do
        expect {
          post :create, {status:  FactoryGirl.attributes_for(:status)}
        }.to change(Status, :count).by(1)
      end 
      
      it "redirects to the status create" do
         post :create, {status:  FactoryGirl.attributes_for(:status)}
         expect(response).to redirect_to(statuses_path)
      end
      it "add like" do
      expect{
       post :add_like, {status_id: status.id, like: FactoryGirl.attributes_for(:like, is_like: true, employee_id: 1, status_id: status.id)}
       }
        end
      end
    end 
  
    describe "POST #create like" do 
    context "Add like  status  with invalid attributes" do
      it "creates a new status" do
        expect {
          post :create, {status:  FactoryGirl.attributes_for(:status)}
        }.to change(Status, :count).by(1)
      end 
      
      it "redirects to the status create" do
         post :create, {status:  FactoryGirl.attributes_for(:status)}
         expect(response).to redirect_to(statuses_path)
      end
      it "renders status index" do
      expect{
       post :add_like, {status_id: status.id, like: FactoryGirl.attributes_for(:like, is_like: true, employee_id: nil, status_id: status.id)}
       }
        end
      end
    end
      
  describe "POST #create like" do 
    context "Add like  status  with invalid attributes" do
      it "creates a new status" do
        expect {
          post :create, {status:  FactoryGirl.attributes_for(:status)}
        }.to change(Status, :count).by(1)
      end 
      
      it "redirects to the status create" do
         post :create, {status:  FactoryGirl.attributes_for(:status)}
         expect(response).to redirect_to(statuses_path)
      end
      it "renders status index" do
      expect{
       post :add_like, {status_id: status.id, like: FactoryGirl.attributes_for(:like, is_like: nil, employee_id: 1, status_id: status.id)}
       }
        end
      end
    end
    
    describe "POST #create un-like" do 
    context "Add like  status  with valid attributes" do
      it "creates a new status" do
        expect {
          post :create, {status:  FactoryGirl.attributes_for(:status)}
        }.to change(Status, :count).by(1)
      end 
      
      it "redirects to the status create" do
         post :create, {status:  FactoryGirl.attributes_for(:status)}
         expect(response).to redirect_to(statuses_path)
      end
      it "Add like to status" do
      expect{
       post :add_like, {status_id: status.id, like: FactoryGirl.attributes_for(:like, is_like: true, employee_id: 1, status_id: status.id)}
       }
        end
        it "Add unlike to status" do
      expect{
       post :remove_like, {status_id: status.id, like: FactoryGirl.attributes_for(:like, is_like: false, employee_id: 1, status_id: status.id)}
       }
        end
      end
    end
  
  describe "POST # Add Comment" do 
    context "Add comment to  status  with valid attributes" do
      it "creates a new status" do
        expect {
          post :create, {status:  FactoryGirl.attributes_for(:status)}
        }.to change(Status, :count).by(1)
      end 
      
      it "redirects to status index" do
         post :create, {status:  FactoryGirl.attributes_for(:status)}
         expect(response).to redirect_to(statuses_path)
      end
      it "Add comment to status" do
      expect{
       post :add_comments, {status_id: status.id, comment: FactoryGirl.attributes_for(:comment, comment: "test",commentable_id: 1, employee_id: 1)}
       }
        end 
        it "Comment is saved to the status" do
      post :create, {status:  FactoryGirl.attributes_for(:status)}
      expect(response).to redirect_to(statuses_path)
        end  
      end
    end
    

   describe "POST # Add Comment" do 
    context "Add comment to  status  with in-valid attributes" do
      it "creates a new status" do
        expect {
          post :create, {status:  FactoryGirl.attributes_for(:status)}
        }.to change(Status, :count).by(1)
      end 
      
      it "redirects to status index" do
         post :create, {status:  FactoryGirl.attributes_for(:status)}
         expect(response).to redirect_to(statuses_path)
      end
      it "Add comment to status with invalid attributes" do
      expect{
       post :add_comments, {status_id: status.id, comment: FactoryGirl.attributes_for(:comment, comment: nil,commentable_id: nil, employee_id: nil)}
       }
        end 
      it "redirects to status index" do
      post :create, {status:  FactoryGirl.attributes_for(:status)}
      expect(response).to redirect_to(statuses_path)
      end 
      end
    end
       
end

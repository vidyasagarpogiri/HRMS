require 'rails_helper'

RSpec.describe CommentsController, :type => :controller do

 before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      employee = FactoryGirl.create(:employee)
      user = employee.user
      sign_in user
      
    end
   
	    let(:status){
      FactoryGirl.create(:status)
	    }
 
 describe "POST #create" do 
 
    context "Create status  with valid attributes" do
      it "creates a new Comment" do
        expect {
          post :create, {status_id: status.id, comment:  FactoryGirl.attributes_for(:comment)}
        }.to change(Comment, :count).by(1)
        end     
      end
      
      context "Create comment for status with invalid attributes " do
     it "renders the 'new' template" do
        post :create, {status_id: status.id, comment:  FactoryGirl.attributes_for(:comment, comment: nil,employee_id: nil)}
         expect(response).to render_template("new")
        end 
      end
      
       context "Create comment for status without comment" do
     it "renders the 'new' template" do
        post :create, {status_id: status.id, comment:  FactoryGirl.attributes_for(:comment, comment: nil, employee_id: 1)}
         expect(response).to render_template("new")
        end 
      end
      
      context "Create comment for status without employee" do
     it "renders the 'new' template" do
        post :create, {status_id: status.id, comment:  FactoryGirl.attributes_for(:comment, comment: nil, employee_id: nil)}
         expect(response).to render_template("new")
        end 
      end 
    end
end

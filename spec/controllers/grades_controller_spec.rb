require 'rails_helper'
#include Warden::Test::Helpers

RSpec.describe GradesController, :type => :controller do
	 before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      employee = FactoryGirl.create(:employee)
      user = employee.user
      sign_in user
    end

    describe "GET #index" do 
    	it "Creats 3 records" do 
    		grade1 = FactoryGirl.create(:grade)
    		grade2 = FactoryGirl.create(:grade)
    		grade3 = FactoryGirl.create(:grade)
    		get :index, {}
    		expect(assigns(:grades)).to eq([grade1, grade2, grade3])
    	end
    end

    describe "GET #new" do
    	it "get new value" do 
    		grade = FactoryGirl.build(:grade)
    		get :new, {}
    		expect(assigns(:grade)).to be_a_new(Grade)
    	end
    end

    describe "Post #create" do 
    	before(:each) do
    		@des  = Designation.create(designation_name: "raju12")
    	end
    	it "create a new grade" do 
    
    		#expect{ post :create, {id: @des, grade: {value: "raju"}}}.to change(Grade,:count).by(1) 
    		expect{ post :create, {grade: {value: "raju", designation_id: @des}}}.to change(@des.grades, :count).by(1) 
    	end 
    end
end
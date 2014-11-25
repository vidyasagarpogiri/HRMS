require 'rails_helper'

RSpec.describe ProjectsController, :type => :controller do

 before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      @employee = FactoryGirl.create(:employee)
      user = @employee.user
      sign_in user
    end
    
    describe "GET #index" do 
    it "populates an array of projects" do
      project1 = @employee.projects.create(FactoryGirl.attributes_for(:project))
      project2 = @employee.projects.create(FactoryGirl.attributes_for(:project))
      project3 = @employee.projects.create(FactoryGirl.attributes_for(:project))
      get :index, {}
      expect(assigns(:projects)).to eq([project1, project2, project3])
    end
   end

end

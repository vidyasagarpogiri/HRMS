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
        xhr :get, :index, {}
        expect(assigns(:projects)).to eq([project1, project2, project3])      
      end
   end
   
    describe "GET #new" do
    it "redirect to new page " do
      xhr :get, :new, {}
      expect(assigns(:project)).to be_a_new(Project)
    end
  end
  
  
  describe "POST #create" do
    it "When we create a new record" do
        expect{ xhr :post, :create, project: FactoryGirl.attributes_for(:project)}.to change(Project,:count).by(1) 
      end
      
      it "After create redirect to index page" do
       xhr :post, :create, project: FactoryGirl.attributes_for(:project)
      end
    it "re-renders the 'new' template" do 
          xhr :post, :create, project: {title: "HRMS", employee_id: nil}
          
        end    
    end

  describe "PUT #update" do
    before :each do
     @updated_project = FactoryGirl.attributes_for(:project, title: "eTeki", employee_id: 1) 
     @project  = FactoryGirl.create(:project)
     @invalid_project = FactoryGirl.attributes_for(:project, employee_id: 1) 
    end 
     context "with valid attributes" do
     it "changes @project's attributes" do
        
        xhr :put, :update, {id: @project, project: @updated_project}
        expect(assigns(:project)).to eq(@project)
      end
      it "Redirects to index path" do
        xhr :put, :update, {id: @project, project: @updated_project}
       
      end
      it "Redirects to index path" do
       xhr :put, :update, {id: @project, project: @updated_project}
        @project.reload
        expect(@project.title).to eq("eTeki")
      end
    end
    
     context "with invalid attributes" do
      it "does not change @project's attributes" do 
        xhr :put, :update, {id: @project, project: @invalid_project}
        @project.reload
        expect(@project.employee_id).to eq(1)
      end
      it "render to edit page" do 
        xhr :put, :update, {id: @project, project: @invalid_project}
       end
     end
    
    
    end
      
    describe "DESTORY delete" do 
    before(:each) do
       @project  = FactoryGirl.create(:project)
    end

    it "destroys the requested project " do 
      expect{ xhr :delete, :destroy, {id: @project}}.to change(Project, :count).by(-1)
    end

    it "redirect_to index page" do 
      xhr :delete, :destroy, {id: @project}
      
    end
  end 

end





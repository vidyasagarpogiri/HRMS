require 'rails_helper'
#include Warden::Test::Helpers

RSpec.describe RecruitmentsController, :type => :controller do
	
 before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      employee = FactoryGirl.create(:employee)
      user = employee.user
      sign_in user
    end

	describe "GET #index" do 
  	it "populates an array of recruitments" do
    	recruitment1 = FactoryGirl.create(:recruitment) 
      recruitment2 = FactoryGirl.create(:recruitment) 
      recruitment3 = FactoryGirl.create(:recruitment) 
      get :index, {}
      expect(assigns(:recruitments)).to eq([recruitment1, recruitment2, recruitment3]) 
    end
	end

  describe "GET #new" do
    it "redirect to new page " do
      get :new, {}
      expect(assigns(:recruitment)).to be_a_new(Recruitment)
    end
  end

  describe "POST #create" do
    context "with valid attributes" do
      it "When we create a new record" do
        expect{ post :create, recruitment: FactoryGirl.attributes_for(:recruitment)}.to change(Recruitment,:count).by(1) 
      end
      it "After create redirect to index page" do
        post :create, recruitment: FactoryGirl.attributes_for(:recruitment)
        expect(response).to redirect_to(recruitments_path) 
      end
    end
    context "with invalid attributes" do
        it "re-renders the 'new' template" do 
          post :create, recruitment: {jobcode: "eTeki12", link: nil,  job_type: "Hey"}
          expect(response).to render_template("new")
        end
    end

  end

  describe "PUT #update" do
    before :each do
     @updated_recruitment = FactoryGirl.attributes_for(:recruitment, title: "Ruby Developer") 
     @recruitment  = FactoryGirl.create(:recruitment)
     @invalid_recruitement = FactoryGirl.attributes_for(:recruitment, link: nil) 
    end 
    context "with valid attributes" do
      it "changes @recruitment's attributes" do
        
        put :update, {id: @recruitment, recruitment: @updated_recruitment}
        expect(assigns(:recruitment)).to eq(@recruitment)
      end

      it "Redirects to index path" do
        
        put :update, {id: @recruitment, recruitment: @updated_recruitment}
        expect(response).to redirect_to(recruitments_path)
      end

      it "Redirects to index path" do
        put :update, {id: @recruitment, recruitment: @updated_recruitment}
        @recruitment.reload
        expect(@recruitment.title).to eq("Ruby Developer")
      end

    end
     context "with invalid attributes" do
      it "does not change @Recruitment's attributes" do 
        put :update, {id: @recruitment, recruitment: @invalid_recruitement}
        @recruitment.reload
        expect(@recruitment.link).to eq("link")
      end
      it "render to edit page" do 
        put :update, {id: @recruitment, recruitment: @invalid_recruitement}
        expect(response).to render_template("edit")
      end

     end

  end

  describe "DESTORY delete" do 
    before(:each) do
       @recruitment  = FactoryGirl.create(:recruitment)
    end

    it "destroys the requested Recruitment " do 
      expect{ delete :destroy, {id: @recruitment}}.to change(Recruitment, :count).by(-1)
    end

    it "redirect_to index page" do 
      delete :destroy, {id: @recruitment}
      expect(response).to redirect_to(recruitments_path)
    end
  end
end
require 'rails_helper'

RSpec.describe TaxBracketsController, :type => :controller do

   before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      employee = FactoryGirl.create(:employee)
      user = employee.user
      sign_in user
    end
    
  
	describe "GET #index" do 
  	it "populates an array of Tax Brackets" do
    	bracket1 = FactoryGirl.create(:tax_bracket) 
      bracket2 = FactoryGirl.create(:tax_bracket) 
      bracket3 = FactoryGirl.create(:tax_bracket)  
      get :index, {}
      expect(assigns(:tax_brackets)).to eq([bracket1, bracket2, bracket3]) 
    end
	end
  
  describe "GET #new" do
    it "assigns a new tax bracket to @tax_bracket" do 
      get :new, {}
      expect(assigns(:tax_bracket)).to be_a_new(TaxBracket)
    end
  end
  
  describe "POST #create" do 
    context "Create with valid attributes" do
      it "creates a new Tax Bracket" do
        expect {
          post :create, {tax_bracket:  FactoryGirl.attributes_for(:tax_bracket)}
        }.to change(TaxBracket, :count).by(1)
      end
      
       it "redirects to the created tax bracket" do
         post :create, {tax_bracket:  FactoryGirl.attributes_for(:tax_bracket)}
         expect(response).to redirect_to(tax_brackets_path)
      end

    end
    
    context "Create with in Valid Attributes" do
      it "can not create with invalid tax bracket attributes" do
        expect {
          post :create, {tax_bracket:  FactoryGirl.attributes_for(:invalid_tax_bracket)}
        }.to_not change(TaxBracket, :count)
      end
      
      it "Render to new template" do
          post :create, {tax_bracket:  FactoryGirl.attributes_for(:invalid_tax_bracket)}
          expect(response).to render_template("new")
      end
      
    end
  end
  
  describe "GET #EDIT" do
    it "assigns a tax bracket to @tax_bracket" do 
      bracket = FactoryGirl.create(:tax_bracket) 
      get :edit, {id: bracket }
      expect(assigns(:tax_bracket)).to eq(bracket)
    end
  end
  
  describe "PUT #Update" do
    let(:new_tax_bracket){
      {bracket: "Hello World", lower_limit: 100}
    }
    let(:bracket){FactoryGirl.create(:tax_bracket)} 
    context "Update with valid parameters" do
   
      it "assigns a tax bracket to @tax_bracket" do 
        put :update, {id: bracket, tax_bracket: FactoryGirl.attributes_for(:tax_bracket) }
        expect(assigns(:tax_bracket)).to eq(bracket)
      end
      
      it "Update Tax Bracket Details " do
        put :update, {id: bracket, tax_bracket: new_tax_bracket }
        bracket.reload
        expect(bracket.lower_limit).to eq(100)
      end
      
      it "redirects to index page" do
        put :update, {id: bracket, tax_bracket: new_tax_bracket }
        expect(response).to redirect_to(tax_brackets_path)
      end
    end
     
    context "Update with in valid parameters" do
        
      it "assigns a tax bracket to @tax_bracket" do 
        put :update, {id: bracket, tax_bracket: FactoryGirl.attributes_for(:invalid_tax_bracket) }
        expect(assigns(:tax_bracket)).to eq(bracket)
      end
      
       it "re-renders the 'edit' template" do
        put :update, {id: bracket, tax_bracket: FactoryGirl.attributes_for(:invalid_tax_bracket) }
        expect(response).to render_template("edit")
      end
    end
  end
  
end

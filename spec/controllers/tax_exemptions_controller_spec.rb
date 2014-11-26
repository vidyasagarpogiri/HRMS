require 'rails_helper'

RSpec.describe TaxExemptionsController, :type => :controller do
  
     before(:each) do
      @request.env["devise.mapping"] = Devise.mappings[:user]
      employee = FactoryGirl.create(:employee)
      user = employee.user
      sign_in user
    end
    
  
	describe "GET #index" do 
  	it "populates an array of Tax Execmptions" do
    	exemption1 = FactoryGirl.create(:tax_exemption) 
      exemption2 = FactoryGirl.create(:tax_exemption) 
      exemption3 = FactoryGirl.create(:tax_exemption)  
      get :index, {}
      expect(assigns(:tax_exemptions)).to eq([exemption1, exemption2, exemption3]) 
    end
	end

  describe "NEW #new" do
    it "Assign new Tax Exemption to @tax_exemption" do
      get :new, {}
      expect(assigns(:tax_exemption)).to be_a_new(TaxExemption)  
    end
  end
  
    describe "POST #create" do 
    context "Create with valid attributes" do
      it "creates a new Tax Exemptions" do
        expect {
          post :create, {tax_exemption:  FactoryGirl.attributes_for(:tax_exemption)}
        }.to change(TaxExemption, :count).by(1)
      end
      
       it "redirects to the created tax Exemption" do
         post :create, {tax_exemption:  FactoryGirl.attributes_for(:tax_exemption)}
         expect(response).to redirect_to(tax_exemptions_path)
      end

    end
    
    context "Create with in Valid Attributes" do
      it "can not create with invalid tax Exemption attributes" do
        expect {
          post :create, {tax_exemption:  FactoryGirl.attributes_for(:invalid_tax_exemption)}
        }.to_not change(TaxExemption, :count)
      end
      
      it "Render to new template" do
          post :create, {tax_exemption:  FactoryGirl.attributes_for(:invalid_tax_exemption)}
          expect(response).to render_template("new")
      end
      
    end
  end
  
  describe "GET #EDIT" do
    it "assigns a tax exemption to @tax_exemption" do 
      exemption = FactoryGirl.create(:tax_exemption) 
      get :edit, {id: exemption }
      expect(assigns(:tax_exemption)).to eq(exemption)
    end
  end
  
  describe "PUT #Update" do
    let(:new_tax_exemption){
      { exemption_limit: 100}
    }
    let(:tax_exemption){FactoryGirl.create(:tax_exemption)} 
    context "Update with valid parameters" do
   
      it "assigns a tax exemption to @tax_exemption" do 
        put :update, {id: tax_exemption, tax_exemption: FactoryGirl.attributes_for(:tax_exemption) }
        expect(assigns(:tax_exemption)).to eq(tax_exemption)
      end
      
      it "Update Tax Exemption Details " do
        put :update, {id: tax_exemption, tax_exemption: new_tax_exemption }
        tax_exemption.reload
        expect(tax_exemption.exemption_limit).to eq(100)
      end
      
      it "redirects to index page" do
         put :update, {id: tax_exemption, tax_exemption: new_tax_exemption }
        expect(response).to redirect_to(tax_exemptions_path)
      end
    end
     
    context "Update with in valid parameters" do
        
      it "assigns a tax exemption to @tax_exemption" do 
        put :update, {id: tax_exemption, tax_exemption: FactoryGirl.attributes_for(:invalid_tax_exemption) }
         expect(assigns(:tax_exemption)).to eq(tax_exemption)
      end
      
       it "re-renders the 'edit' template" do
       put :update, {id: tax_exemption, tax_exemption: FactoryGirl.attributes_for(:invalid_tax_exemption) }
        expect(response).to render_template("edit")
      end
    end
  end
  
end

require 'rails_helper'

RSpec.describe AppraisalCyclesController, :type => :controller do
  
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    employee = FactoryGirl.create(:employee)
    user = employee.user
    sign_in user
  end
  
  describe 'GET #index' do
    it 'display list of appraisal_cycles' do
      review_cycle1 = FactoryGirl.create(:appraisal_cycle)
      review_cycle2 = FactoryGirl.create(:appraisal_cycle)
      get :index
      expect(assigns(:appraisal_cycles)).to match_array([review_cycle1, review_cycle2])
    end
  end
  
  describe 'GET #new' do
    it 'has create a new instance of appraisal_cycle' do
      xhr :get, :new, {}
      expect(assigns(:appraisal_cycle)).to be_a_new(AppraisalCycle)
    end
  end
  
  describe 'POST #create' do
    it 'has create a new record and change its count by 1' do
      expect{
        xhr :post, :create, appraisal_cycle: FactoryGirl.attributes_for(:appraisal_cycle)
      }.to change(AppraisalCycle, :count).by(1)
    end
    
    it 'when resource has found' do
      xhr :post, :create, appraisal_cycle: FactoryGirl.attributes_for(:appraisal_cycle)
      expect(response.status).to eq(200)
    end
  end
  
  describe 'GET #show' do
    it 'assigns the requested contact to @appraisal_cycle' do
      appraisal_cycle = FactoryGirl.create(:appraisal_cycle)
      get :show, id: appraisal_cycle
      expect(assigns(:appraisal_cycle)).to eq(appraisal_cycle)
    end
    
  end
end

require 'rails_helper'

RSpec.describe InvestmentDeclaration, :type => :model do
  before(:each) do
    @employee =  FactoryGirl.create(:employee) 
    FactoryGirl.create(:investment_declaration, employee_id: @employee.id)
  end
  
  describe "Checking Sum of yearly Investment" do
    
    it "Checking 2014 assesment year investment declaration" do
      sum = InvestmentDeclaration.sum_of_declation(@employee, 2014)
      expect(sum).to eq(50000)
    end
    
    
  end
   
end

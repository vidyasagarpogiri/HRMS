require 'rails_helper'

RSpec.describe TdsCalculation, :type => :model do
  describe "Checking TdsCalculation Model" do
    
  before(:each) do
  #Creating all Tax Brackets
    FactoryGirl.create(:low_tax_bracket)
    FactoryGirl.create(:medium_tax_bracket)
    FactoryGirl.create(:high_tax_bracket)
    FactoryGirl.create(:very_high_tax_bracket)
    @employee =  FactoryGirl.create(:employee) 
    FactoryGirl.create(:investment_declaration, employee_id: @employee.id)
  end
   
   let(:gross) { 10000 }
   

    it "Initialize attributes" do
      tds = TdsCalculation.new(gross, @employee.id)
      expect(tds.instance_variable_get(:@gross)).to eq(gross)
      expect(tds.instance_variable_get(:@employee)).to eq(@employee)
    end
   
    
    it "Calling Total Savings Method" do
       tds = TdsCalculation.new(gross, @employee.id)
       total_savings = tds.total_savings
       expect(total_savings).to eq(50000)
    end
    
    it "Calling Net Taxble Income" do
      tds = TdsCalculation.new(gross, @employee.id)
      total_net_taxble_income = tds.net_taxble_income
      expect(total_net_taxble_income).to eq(70000)
    end
    
    it "calling Tax Method" do
      tds = TdsCalculation.new(30000, @employee.id)
      tax = tds.tax
      expect(tax).to eq(6179.897)
    end
    
    it "Calling This Month TDS" do
      tds = TdsCalculation.new(30000, @employee.id)
      this_month_tax = tds.tds_for_this_month
      expect(this_month_tax).to eq(1235.9794)
    end
    
    it "Form 16 Update" do 
      tds = TdsCalculation.new(30000, @employee.id)
      expect{ tds.tds_and_income_tax_update }.to change(@employee.pay_roll_masters,:count).by(1) 
      
    end
    
  end
end



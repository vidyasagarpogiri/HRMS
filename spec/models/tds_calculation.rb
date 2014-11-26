require 'rails_helper'

RSpec.describe TdsCalculation, :type => :model do
  describe "Checking TdsCalculation Model" do
    
   let(:gross) { 10000 }
   let(:employee_id) { 1 }

    it "Initialize attributes" do
      tds = TdsCalculation.new(gross, employee_id)
      expect(tds.instance_variable_get(:@gross)).to eq(gross)
    end
   
    
    it "Is invalid without Tax Exemption" do
      
    end
    
  end
end



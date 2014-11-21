require 'rails_helper'

RSpec.describe TaxBracket, :type => :model do
  describe "Checking Tax Bracket Model Level Validattions" do
    
    it "Create TaxBracket With Valid Deatils" do
      expect(FactoryGirl.create(:tax_bracket)).to be_valid
    end
    
    it "Is invalid without Lower Limit" do
      expect(FactoryGirl.build(:tax_bracket, lower_limit: nil, upper_limit: 10000, tax_percentage: 4, min_tax: 10)).to_not be_valid
    end
    
    it "Is invalid without Upper Limit" do
      expect(FactoryGirl.build(:tax_bracket, lower_limit: 10000, upper_limit: nil, tax_percentage: 4, min_tax: 10)).to_not be_valid
    end
    
    it "Is invalid without Tax Percentage" do
      expect(FactoryGirl.build(:tax_bracket, lower_limit: nil, upper_limit: 10000, tax_percentage: nil, min_tax: 10)).to_not be_valid
    end
    
    it "Is invalid without Minimum Tax" do
      expect(FactoryGirl.build(:tax_bracket, lower_limit: nil, upper_limit: 10000, tax_percentage: 20, min_tax: nil)).to_not be_valid
    end
    
    it "Check the Custom Validation(Lower Limit is greater than Upper Limit)" do
      expect(FactoryGirl.build(:custom_tax_bracket)).to_not be_valid
    end
  end
   
end

require 'rails_helper'

RSpec.describe TaxExemption, :type => :model do
  describe "Checking TaxExemption Model Level Validattions" do
    
    it "Create TaxBracket With Valid Deatils" do
      expect(FactoryGirl.create(:tax_exemption)).to be_valid
    end
    
    it "Is invalid without Tax Exemption" do
      expect(FactoryGirl.build(:tax_exemption, gender: "Male", exemption_limit: nil)).to_not be_valid
    end
    
  end
end

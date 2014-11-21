require 'rails_helper'
RSpec.describe Recruitment, :type => :model do
	describe "Checking modle level validattions" do 
		it "check the validations" do
			expect(FactoryGirl.build(:grade)).to be_valid
		end

		it "check the in validations" do
			expect(FactoryGirl.build(:invalid_grade)).to_not be_valid
		end
	end
end

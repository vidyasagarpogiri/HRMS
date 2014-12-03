require 'rails_helper'

RSpec.describe Appraisal, :type => :model do
  it "create appraisal cycle with valid attributes" do 
		expect(FactoryGirl.create(:appraisal_cycle)).to be_valid
	end
	it "is invalid without title" do 
		expect(FactoryGirl.build(title: nil, description:"this form will indicate your performance on different tasks", start_date: "25/11/2014", end_date: "01/12/2014", review_period: "Qpr")).to_not be_valid
	end
	it "is invalid without description" do 
		expect(FactoryGirl.build(title: "Review1", description: nil, start_date: "25/11/2014", end_date: "01/12/2014", review_period: "Qpr")).to_not be_valid
	end
	it "is invalid without start date" do 
		expect(FactoryGirl.build(title: "Review1", description:"this form will indicate your performance on different tasks", start_date: nil, end_date: "01/12/2014", review_period: "Qpr")).to_not be_valid
	end
	it "is invalid without end date" do 
		expect(FactoryGirl.build(title: "Review1", description:"this form will indicate your performance on different tasks", start_date: "25/11/2014", end_date: nil, review_period: "Qpr")).to_not be_valid
	end
	it "is invalid without review period" do 
		expect(FactoryGirl.build(title: "Review1", description:"this form will indicate your performance on different tasks", start_date: "25/11/2014", end_date: "01/12/2014", review_period: nil)).to_not be_valid
	end
end

require 'rails_helper'

RSpec.describe ReviewElement, :type => :model do
  it "create review element with valid attribute" do
    expect(FactoryGirl.create(:review_element)).to be_valid
  end
  
  it "invalid with out review element" do
    expect(FactoryGirl.build(review_element: nil, performance_indicator: "Writing blogs is 25% of your appraisal")).to_not be_valid
  end
  
  it "invalid with out perfromance indicator" do
    expect(FactoryGirl.build(review_element: "Writing Blogs", performance_indicator: nil)).to_not be_valid
  end
end

require 'rails_helper'

RSpec.describe Recruitment, :type => :model do
	it "Hello world" do 
		expect(FactoryGirl.build(:recruitment)).to be_valid
	end
	
end

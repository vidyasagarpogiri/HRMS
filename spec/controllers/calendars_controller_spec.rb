require 'rails_helper'

RSpec.describe CalendarsController, :type => :controller do
  
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    employee = FactoryGirl.create(:employee)
    user = employee.user
    sign_in_user
  end
end

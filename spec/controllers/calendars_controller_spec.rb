require 'rails_helper'

RSpec.describe CalendarsController, :type => :controller do
  
  before(:each) do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    employee = FactoryGirl.create(:employee)
    user = employee.user
    sign_in_user
  end
  
  let(:respective_events){
    (event_name: "Ugadhi", event_date: "10-03-2015")
  }
  
  describe "GET #reporting_manager_calendar" do
    it "Reportees events Calendar" do
      @event1 = FactoryGirl.attributes_for(:event, event_name: "Ugadhi")
      @event2 = FactoryGirl.attributes_for(:event, event_name)
    end
  end
  
end

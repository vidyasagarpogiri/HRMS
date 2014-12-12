require 'rails_helper'

RSpec.describe AppraisalCycle, :type => :model do
  it "create appraisal cycle with valid attributes" do 
		expect(FactoryGirl.create(:appraisal_cycle)).to be_valid
	end
	it "Is invalid without title" do
      expect(FactoryGirl.build(:appraisal_cycle, title: nil, start_date: "24/11/2014", end_date: "29/11/2014", period: 3, employee_dead_line: "25/11/2014", manager_dead_line: "26/11/2014", discussion_dead_line: "28/11/2014", department_id: 1)).to_not be_valid
  end
  it "Is invalid without start date" do
      expect(FactoryGirl.build(:appraisal_cycle, title: "Appraisal1", start_date: nil, end_date: "29/11/2014", period: 3, employee_dead_line: "25/11/2014", manager_dead_line: "26/11/2014", discussion_dead_line: "28/11/2014", department_id: 1)).to_not be_valid
  end
  it "Is invalid without end date" do
      expect(FactoryGirl.build(:appraisal_cycle, title: "Appraisal1", start_date: "24/11/2014", end_date: nil, period: 3, employee_dead_line: "25/11/2014", manager_dead_line: "26/11/2014", discussion_dead_line: "28/11/2014", department_id: 1)).to_not be_valid
  end
  it "Is invalid without period" do
      expect(FactoryGirl.build(:appraisal_cycle, title:"Appraisal1", start_date: "24/11/2014", end_date: "29/11/2014", period: nil, employee_dead_line: "25/11/2014", manager_dead_line: "26/11/2014", discussion_dead_line: "28/11/2014", department_id: 1)).to_not be_valid
  end
  it "Is invalid without employee dead line" do
      expect(FactoryGirl.build(:appraisal_cycle, title: "Appraisal1", start_date: "24/11/2014", end_date: "29/11/2014", period: 3, employee_dead_line: nil, manager_dead_line: "26/11/2014", discussion_dead_line: "28/11/2014", department_id: 1)).to_not be_valid
  end
  it "Is invalid without manager dead line" do
      expect(FactoryGirl.build(:appraisal_cycle, title: "Appraisal1", start_date: "24/11/2014", end_date: "29/11/2014", period: 3, employee_dead_line: "25/11/2014", manager_dead_line: nil, discussion_dead_line: "28/11/2014", department_id: 1)).to_not be_valid
  end
  it "Is invalid without discussion dead line" do
      expect(FactoryGirl.build(:appraisal_cycle, title: "Appraisal1", start_date: "24/11/2014", end_date: "29/11/2014", period: 3, employee_dead_line: "25/11/2014", manager_dead_line: "26/11/2014", discussion_dead_line: nil, department_id: 1)).to_not be_valid
  end
  it "Is invalid without department" do
      expect(FactoryGirl.build(:appraisal_cycle, title: "Appraisal1", start_date: "24/11/2014", end_date: "29/11/2014", period: 3, employee_dead_line: "25/11/2014", manager_dead_line: "26/11/2014", discussion_dead_line: "28/11/2014", department_id: nil)).to_not be_valid
  end
end

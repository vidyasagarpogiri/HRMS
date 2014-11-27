require 'rails_helper'

RSpec.describe Project, :type => :model do
    describe Project do
      it "is valid with valied attributes" do
        expect(Project.create(title: "HRMS", description: "some text", start_date: "Fri, 21 Sep 2014", end_date: "Fri, 21 Nov 2014", roles: "some role1,some role2", tasks_performed: "task1,task2", skills: "skill1,skill2", employee_id: 1)).to be_valid
      end
      
      it " is not valid without title" do
      expect(Project.create(title:nil, description: "some text", start_date: "Fri, 21 Sep 2014", end_date: "Fri, 21 Nov 2014", roles: "some role1,some role2", tasks_performed: "task1,task2", skills: "skill1,skill2", employee_id: 1)).to_not be_valid
      end
      
      it " is not valid without employee_id" do
      expect(Project.create(title: "HRMS", description: "some text", start_date: "Fri, 21 Sep 2014", end_date: "Fri, 21 Nov 2014", roles: "some role1,some role2", tasks_performed: "task1,task2", skills: "skill1,skill2", employee_id: nil)).to_not be_valid
      end
      
      it " is not valid without title and employee_id" do
      expect(Project.create(title: nil, description: "some text", start_date: "Fri, 21 Sep 2014", end_date: "Fri, 21 Nov 2014", roles: "some role1,some role2", tasks_performed: "task1,task2", skills: "skill1,skill2", employee_id: nil)).to_not be_valid
      end
  end
end

class AddDepartments < ActiveRecord::Migration
  def change
    puts "Removing All Departments"
    puts "---Creating Departments----"
    Department.destroy_all
    ["Development", "HR", "Accounts"].each do |dept|
      Department.create(:department_name => dept ) 
    end
    puts "-------Creating Designations----------"
    Department.find_by_department_name("Development").designations.create(designation_name: "Junior Developer")
    Department.find_by_department_name("Development").designations.create(designation_name: "Senior Developer")
    
    Department.find_by_department_name("HR").designations.create(designation_name: "HR Manager")
    Department.find_by_department_name("HR").designations.create(designation_name: "Senior HR Executive")
    Department.find_by_department_name("HR").designations.create(designation_name: "Junior HR")
    
    Department.find_by_department_name("Accounts").designations.create(designation_name: "Financial Manager")
    Department.find_by_department_name("Accounts").designations.create(designation_name: "Senior Account Executive")
    Department.find_by_department_name("Accounts").designations.create(designation_name: "Junior Accountant")
    
    puts "-------Creating Levels----------"
    Designation.all.each do |desg|
      ["Level1", "Level2", "Level3"].each do |level|
        Grade.create(:value => level, :designation_id =>  desg.id) 
      end
    end
    
  end
end


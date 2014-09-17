# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# seeds for bloodgroup


#seeds for country


Address.destroy_all
JobLocation.destroy_all
Department.destroy_all
BloodGroup.destroy_all
FfStatus.destroy_all
Designation.destroy_all
Grade.destroy_all
Role.destroy_all
Employee.destroy_all
Education.destroy_all
Experience.destroy_all
Promotion.destroy_all
EmailEttiquitie.destroy_all
Salary.destroy_all
LeaveType.destroy_all

Group.destroy_all;
StaticAllowance.destroy_all


Allowance.destroy_all
 


#sekharberi@1989
 @user = User.invite!(:email =>  "vidyasagar.pogiri@amzur.com", :skip_invitation => true)
 @user1 = User.invite!(:email =>  "balaraju.vankala@amzur.com", :skip_invitation => true)
 @user2 = User.invite!(:email =>  "priyanka.muddana@amzur.com", :skip_invitation => true)
 @user3 = User.invite!(:email =>  "ramarao.pattabhi@amzur.com", :skip_invitation => true)


Address.create(:id=>1,:line1 => "BAY STREET",:line => "GUL END",:city => "Sydney",:state=>"New South Wales",:country=>"Australia",:zipcode=>"2000")
Address.create(:id=>2,:line1 => "street 1",:line => "near KFC",:city => "Vizag",:state=>"Andhra",:country=>"India",:zipcode=>"530003")
Address.create(:id=>3,:line1 => "BEACH ROAD",:line => "OPP:IMAX THEATRE",:city => "Avalon",:state=>"California",:country=>"Los Angels",:zipcode=>" 90704")
Address.create(:id=>4,:line1 => "MARINE TOWERS",:line => "Kukatpally",:city => "Hyderabad",:state=>"Telangana",:country=>"India",:zipcode=>"500001")
Address.create(:id=>5,:line1 => "400 N",:line => "Ashley Drive #2200",:city => "Tampa",:state=>"Florida",:country=>"USA",:zipcode=>"33602")
Address.create(:id=>6,:line1 => "9-29-22,2nd Floor,Pioneer Sankar Shantiniketan,",:line => "Balaji Nagar,Siripuram,",:city => "Visakhapatnam",:state=>"Andhra Pradesh",:country=>"India",:zipcode=>" 530003")
addresses = Address.all.pluck(:id)

(3..5).each do 
JobLocation.create( :address_id => addresses[rand(addresses.length)])
end
JobLocations = JobLocation.all.pluck(:id)

#-------------------------------------------------------------------------------------#
["DEVELOPMENT", "HR", "ACCOUNTS", "BUSINESS DEVELOPMENT"].each do |dept|
  Department.create(:department_name => dept ) 
end
Departments = Department.all.pluck(:id)

Department.all.each do |dept|
  
  ["Level1", "Level2", "Level3"].each do |level|
    Grade.create(:value => level,:department_id => dept.id) 
  end
  
  ["Junior #{dept.department_name}", "Senior #{dept.department_name}"].each do |desg|
    Designation.create(:designation_name => desg, :department_id => dept.id ) 
  end
  
end
Grades = Grade.all.pluck(:id)
Designations = Designation.all.pluck(:id)
#-----------------------------------------------------------------------------------------------------#

["O+ve", "O-ve", "A+ve", "A+ve", "B+ve", "B-ve", "AB+ve", "AB-ve", "ABO (Bombay Blood Group)"].each do |bloodgrp|
BloodGroup.create(:blood_group_name => bloodgrp ) 
end
BloodGroups = BloodGroup.all.pluck(:id)

["Open", "Hold", "Closed"].each do |ffstatus|
FfStatus.create(:status_name => ffstatus ) 
end
FfStatuses = FfStatus.all.pluck(:id)




["Employee", "HR", "Tech Lead", "Manager"].each do |role|
  Role.create(:role_name => role ) 
end
Roles = Role.all.pluck(:id)



Employee.create(:id => 1,:employee_id => 1, :title=> "Mr.", :first_name=>"Meher",:last_name=>"Goru",:date_of_birth=>"2014-12-30", :gender=>"male", :marital_status=>"single", :total_experience=>"6.5",
:status=>"Active", :mobile_number=>"9876543219",:father_name=>"Father",:pan=>"pan", :date_of_confirmation=>"2013-05-09",:date_of_join=>"2014-03-03",
:image_url=> "image",
:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:grade_id=>Grades[rand(Grades.length)],:role_id=>2,:job_location_id=>JobLocations[rand(JobLocations.length)], :salary_id=>3,:avatar=>"406929_2668579486846_928068538_n.jpg", :user_id => @user.id, :alternate_email => "email@mail.com")

Employee.create(:id => 2,:employee_id => 2, :title=> "Mr.", :first_name=>"bala",:last_name=>"nemani",:date_of_birth=>"2005-05-03", :gender=>"male", :marital_status=>"single", :total_experience=>"13",
:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-15-12",:date_of_join=>"2006-11-03",
 :image_url=> "image",
:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)],
:grade_id=>Grades[rand(Grades.length)],:role_id=>2,:job_location_id=>JobLocations[rand(JobLocations.length)],
:salary_id=>3,:avatar=>"best-employee-md.png", :user_id => @user1.id,:alternate_email => "email@mail.com")


Employee.create(:id => 3,:employee_id => 3, :title=> "Miss.", :first_name=>"Sonia",:last_name=>"Kumar",:date_of_birth=>"2005-05-03", :gender=>"female", :marital_status=>"single", :total_experience=>"1",:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-15-12",:date_of_join=>"2006-11-03",:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-15-12",:date_of_join=>"2006-11-03",:image_url=> "image",:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:grade_id=>Grades[rand(Grades.length)], :role_id=>2,:job_location_id=>JobLocations[rand(JobLocations.length)],
:salary_id=>2,:avatar=>"gates_print.jpg", :user_id => @user2.id,:alternate_email => "email@mail.com")


Employee.create(:id => 4,:employee_id => 4, :title=> "Mr.", :first_name=>"pattabhi",:last_name=>"ramarao",:date_of_birth=>"2005-05-03", :gender=>"female", :marital_status=>"single", :total_experience=>"1",:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-15-12",:date_of_join=>"2006-11-03",:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-15-12",:date_of_join=>"2006-11-03",:image_url=> "image",:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:grade_id=>Grades[rand(Grades.length)], :role_id=>2,:job_location_id=>JobLocations[rand(JobLocations.length)],
:salary_id=>2,:avatar=>"gates_print.jpg", :user_id => @user3.id, :alternate_email => "email@mail.com")



Employees = Employee.all.pluck(:id)


["Need Holidays list for year 2014", "Need Hand book/Scribbling pad"].each do |ettiquite|
EmailEttiquitie.create(:ettiquite => ettiquite ) 
end
EmailEttiquities = EmailEttiquitie.all.pluck(:id)


Salary.create(:ctc_fixed =>"12000",:basic_salary => "4000",:gross_salary=>"16000",:gratuity =>"2500",:bonus=>"1500",:medical_insurance=>"2500") 
Salary.create(:ctc_fixed =>"16000",:basic_salary => "2000",:gross_salary=>"13500",:gratuity =>"1500",:bonus=>"1600",:medical_insurance=>"2500")
Salary.create(:ctc_fixed =>"22000",:basic_salary => "3500",:gross_salary=>"16500",:gratuity =>"2000",:bonus=>"1700",:medical_insurance=>"2500")
Salary.create(:ctc_fixed =>"10000",:basic_salary => "4500",:gross_salary=>"18000",:gratuity =>"2200",:bonus=>"1000",:medical_insurance=>"2500")

Salaries = Salary.all.pluck(:id)

["Sick Leave", "Floating Leave" , "Casual Leave","Carry Forward Leave"].each do |leave|
LeaveType.create(:type_name => leave ) 
end
LeaveTypes = LeaveType.all.pluck(:id)

Group.all.each do |group|
  ReportingManager.create(employee_id: rand(1..Employee.count), group_id: group.id)

#static allowance
StaticAllowance.create(:allowance_name => 'HRA', :percentage => 25.0)
StaticAllowance.create(:allowance_name => 'Car Allowance', :percentage => 15.0)
StaticAllowance.create(:allowance_name => 'DA', :percentage => 5.0)



end


Allowance.create(:allowance_name =>"travel allawance",:value=>"1500.00",:salary_id=>Salaries[rand(Salaries.length)],:applicable=>"true") 
Allowance.create(:allowance_name =>"travel allawance",:value=>"2500.00",:salary_id=>Salaries[rand(Salaries.length)],:applicable=>"false") 
Allowance.create(:allowance_name =>"travel allawance",:value=>"500.00",:salary_id=>Salaries[rand(Salaries.length)],:applicable=>"true") 
Allowance.create(:allowance_name =>"travel allawance",:value=>"1000.00",:salary_id=>Salaries[rand(Salaries.length)],:applicable=>"false") 

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
Group.destroy_all

#sekharberi@1989
 @user = User.invite!(:email =>  "vidyasagar.pogiri@amzur.com", :skip_invitation => true)
 @user1 = User.invite!(:email =>  "balaraju.vankala@amzur.com", :skip_invitation => true)
 @user2 = User.invite!(:email =>  "priyanka.muddana@amzur.com", :skip_invitation => true)
 @user3 = User.invite!(:email =>  "ramarao.pattabhi@amzur.com", :skip_invitation => true)

  
Address.create(:id=>1,:line1 => "BAY STREET",:line => "GUL END",:city => "Sydney",:state=>"New South Wales",:country=>"Australia",:zipcode=>"2000")
Address.create(:id=>2,:line1 => "street 1",:line => "near KFC",:city => "Vizag",:state=>"Andhra",:country=>"India",:zipcode=>"530003")
Address.create(:id=>3,:line1 => "BEACH ROAD",:line => "OPP:IMAX THEATRE",:city => "Avalon",:state=>"California",:country=>"Los Angels",:zipcode=>" 90704")
Address.create(:id=>4,:line1 => "MARINE TOWERS",:line => "Kukatpally",:city => "Hyderabad",:state=>"Telangana",:country=>"India",:zipcode=>"500001")
addresses = Address.all.pluck(:id)

(0..3).each do 
  JobLocation.create( :address_id => addresses[rand(addresses.length)])
end
JobLocations = JobLocation.all.pluck(:id)

["Development", "HR", "ACCOUNTS", "BUSINESS DEVELOPMENT"].each do |dept|
  Department.create(:department_name => dept ) 
end
Departments = Department.all.pluck(:id)

["O+ve", "O-ve", "A+ve", "A+ve", "B+ve", "B-ve", "AB+ve", "AB-ve", "ABO (Bombay Blood Group)"].each do |bloodgrp|
BloodGroup.create(:blood_group_name => bloodgrp ) 
end
BloodGroups = BloodGroup.all.pluck(:id)

["Open", "Hold", "Closed"].each do |ffstatus|
FfStatus.create(:status_name => ffstatus ) 
end
FfStatuses = FfStatus.all.pluck(:id)

["Developer", "HR", "Business Developer"].each do |desg|
Designation.create(:designation_name => desg ) 
end
Designations = Designation.all.pluck(:id)

["Jr.Software Engineer", "Sr.Software Engineer", "Jr.HR", "Sr.HR"].each do |grade|
Grade.create(:value => grade ) 
end
Grades = Grade.all.pluck(:id)

["Employee", "HR", "Tech Lead", "Manager"].each do |role|
  Role.create(:role_name => role ) 
end
Roles = Role.all.pluck(:id)

["USA", "INDIA"].each do |group|
Group.create(:group_name => group ) 
end
Groups = Group.all.pluck(:id)

Employee.create(:id => 1,:employee_id => 1, :title=> "Mr.", :first_name=>"Meher",:last_name=>"Goru",:date_of_birth=>"2014-12-30", :gender=>"male", :marital_status=>"single", :total_experience=>"6.5",
:status=>"Active", :mobile_number=>"9876543219",:father_name=>"Father",:pan=>"pan", :date_of_confirmation=>"2013-05-09",:date_of_join=>"2014-03-03",
:image_url=> "image",
:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:designation_id=>Designations[rand(Designations.length)],
:grade_id=>Grades[rand(Grades.length)],:role_id=>1,:job_location_id=>JobLocations[rand(JobLocations.length)], :salary_id=>3,:avatar=>"406929_2668579486846_928068538_n.jpg", :user_id => @user.id, :group_id=>Groups[rand(Groups.length)])

Employee.create(:id => 2,:employee_id => 2, :title=> "Mr.", :first_name=>"bala",:last_name=>"nemani",:date_of_birth=>"2005-05-03", :gender=>"male", :marital_status=>"single", :total_experience=>"13",
:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-15-12",:date_of_join=>"2006-11-03",
 :image_url=> "image",
:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:designation_id=>Designations[rand(Designations.length)],
:grade_id=>Grades[rand(Grades.length)],:role_id=>2,:job_location_id=>JobLocations[rand(JobLocations.length)],
:salary_id=>3,:avatar=>"best-employee-md.png", :user_id => @user1.id,:group_id=>Groups[rand(Groups.length)])


Employee.create(:id => 3,:employee_id => 3, :title=> "Miss.", :first_name=>"Sonia",:last_name=>"Kumar",:date_of_birth=>"2005-05-03", :gender=>"female", :marital_status=>"single", :total_experience=>"1",:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-15-12",:date_of_join=>"2006-11-03",:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-15-12",:date_of_join=>"2006-11-03",:image_url=> "image",:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:designation_id=>Designations[rand(Designations.length)],
:grade_id=>Grades[rand(Grades.length)],:role_id=>2,:job_location_id=>JobLocations[rand(JobLocations.length)],
:salary_id=>2,:avatar=>"gates_print.jpg",:group_id=>Groups[rand(Groups.length)], :user_id => @user2.id)

Employee.create(:id => 4,:employee_id => 4, :title=> "Mrs.", :first_name=>"Chethan",:last_name=>"Sharma",:date_of_birth=>"2001-05-03", :gender=>"male", :marital_status=>"single", :total_experience=>"1",
:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-02-05",:date_of_join=>"2010-11-03",
 :image_url=> "image",
:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:designation_id=>Designations[rand(Designations.length)],
:grade_id=>Grades[rand(Grades.length)],:role_id=>Roles[rand(Roles.length)],:job_location_id=>JobLocations[rand(JobLocations.length)],
:salary_id=>1,:avatar=>"406929_2668579486846_928068538_n.jpg",:group_id=>Groups[rand(Groups.length)])




Education.create(:id=>1, :specilization=>"B.Tech", :institute=> "AU", year_of_pass: "2007",:cgpa_percentage=> "78.50", :Employee_id=>1)
Education.create(:id=>5, :specilization=>"M.Tech", :institute=> "JNTU", year_of_pass: "2012",:cgpa_percentage=> "81.20", :Employee_id=>1)

Education.create(:id=>2, :specilization=>"MBA", :institute => "GITAM",year_of_pass: "2010",:cgpa_percentage=> "91.50", :Employee_id=>2)

Education.create(:id=>3, :specilization=>"MCA", :institute=> "AU", year_of_pass: "2010",:cgpa_percentage=> "82.50", :Employee_id=>3)

Education.create(:id=>4, :specilization=>"M.Tech", :institute=> "AU",year_of_pass: "2010",:cgpa_percentage=> "76.50", :Employee_id=>4)


Experience.create(:id=>1,:previous_company=>"Microsoft",:last_designation=>"Software Engineer",:from_date=>"2012-10-11",:to_date=>"2013-06-12",:employee_id=> 1)
Experience.create(:id=>2,:previous_company=>"TCS",:last_designation=>"Sr.Software Engineer",:from_date=>"2013-08-01",:to_date=>"2014-08-28",:employee_id=> 1)

Experience.create(:id=>3,:previous_company=>"Infosys",:last_designation=>"Software Engineer",:from_date=>"2012-10-11",:to_date=>"2013-06-12",:employee_id=> 2)

Experience.create(:id=>4,:previous_company=>"TCS",:last_designation=>"Java Developer",:from_date=>"2013-08-01",:to_date=>"2014-08-28",:employee_id=> 3)

Experience.create(:id=>5,:previous_company=>"Wipro",:last_designation=>".Net Developer",:from_date=>"2013-08-01",:to_date=>"2014-08-28",:employee_id=> 4)


["Need Holidays list for year 2014", "Need Hand book/Scribbling pad"].each do |ettiquite|
EmailEttiquitie.create(:ettiquite => ettiquite ) 
end
EmailEttiquities = EmailEttiquitie.all.pluck(:id)

["12000", "15000" , "20000"].each do |sal|
Salary.create(:ctc_fixed => sal ) 
end
Salaries = Salary.all.pluck(:id)

["Sick Leave", "Floating Leav" , "Casual Leave","Carry Forward Leave"].each do |leave|
LeaveType.create(:type_name => leave ) 
end
LeaveTypes = LeaveType.all.pluck(:id)


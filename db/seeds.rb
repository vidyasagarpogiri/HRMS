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
 

Address.create(:id=>1,:line1 => "BAY STREET",:line => "GUL END",:city => "Sydney",:state=>"New South Wales",:country=>"Australia",:zipcode=>"2000")
Address.create(:id=>2,:line1 => "street 1",:line => "near KFC",:city => "Vizag",:state=>"Andhra",:country=>"India",:zipcode=>"530003")
Address.create(:id=>3,:line1 => "BEACH ROAD",:line => "OPP:IMAX THEATRE",:city => "Avalon",:state=>"California",:country=>"Los Angels",:zipcode=>" 90704")
Address.create(:id=>4,:line1 => "MARINE TOWERS",:line => "Kukatpally",:city => "Hyderabad",:state=>"Telangana",:country=>"India",:zipcode=>"500001")
addresses = Address.all.pluck(:id)

JobLocation.create(:id=>1,:address_id => addresses[rand(addresses.length)])
JobLocation.create(:id=>2,:address_id => addresses[rand(addresses.length)])
JobLocation.create(:id=>3,:address_id => addresses[rand(addresses.length)])
JobLocation.create(:id=>4,:address_id => addresses[rand(addresses.length)])
JobLocations = JobLocation.all.pluck(:id)

Department.create(:id=>1,:department_name=>"Development") 
Department.create(:id=>2,:department_name=>"HR") 
Department.create(:id=>3,:department_name=>"ACCOUNTS")
Department.create(:id=>4,:department_name=>"BUSINESS DEVELOPMENT")  
Departments = Department.all.pluck(:id)

BloodGroup.create(:id=>1,:blood_group_name=>"O+ve") 
BloodGroup.create(:id=>2,:blood_group_name=>"O-ve") 
BloodGroup.create(:id=>3,:blood_group_name=>"A+ve") 
BloodGroup.create(:id=>4,:blood_group_name=>"A-ve")
BloodGroup.create(:id=>5,:blood_group_name=>"B+ve") 
BloodGroup.create(:id=>6,:blood_group_name=>"B-ve") 
BloodGroup.create(:id=>7,:blood_group_name=>"AB+ve") 
BloodGroup.create(:id=>8,:blood_group_name=>"AB-ve")
BloodGroup.create(:id=>9,:blood_group_name=>"ABO (Bombay Blood Group)") 
BloodGroups = BloodGroup.all.pluck(:id)

FfStatus.create(:id=>1,:status_name=>"Open")
FfStatus.create(:id=>2,:status_name=>"Hold")
FfStatus.create(:id=>3,:status_name=>"Closed")
FfStatuses = FfStatus.all.pluck(:id)

Designation.create(:id=>1,:designation_name=>"Developer")
Designation.create(:id=>2,:designation_name=>"HR")
Designation.create(:id=>3,:designation_name=>"Business Developer")
Designations = Designation.all.pluck(:id)

Grade.create(:id=>1,:value=>"Jr.Software Engineer")
Grade.create(:id=>2,:value=>"Sr.Software Engineer")
Grade.create(:id=>3,:value=>"Jr.HR")
Grade.create(:id=>4,:value=>"Sr.HR")
Grades = Grade.all.pluck(:id)

Role.create(:id=>1,:role_name=>"employee")
Role.create(:id=>2,:role_name=>"hr")
Role.create(:id=>3,:role_name=>"tech lead")
Role.create(:id=>4,:role_name=>"manager")
Roles = Role.all.pluck(:id)


Employee.create(:id => 1,:employee_id => 1, :title=> "Mr.", :first_name=>"Meher",:last_name=>"Goru",:date_of_birth=>"2014-12-30", :gender=>"male", :marital_status=>"single", :total_experience=>"6.5",
:status=>"Active", :mobile_number=>"9876543219",:father_name=>"Father",:pan=>"pan", :date_of_confirmation=>"2013-05-09",:date_of_join=>"2014-03-03",
:image_url=> "image",
:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:designation_id=>Designations[rand(Designations.length)],
:grade_id=>Grades[rand(Grades.length)],:role_id=>Roles[rand(Roles.length)],:job_location_id=>JobLocations[rand(JobLocations.length)],
:permanent_address_id=>JobLocations[rand(JobLocations.length)],:present_address_id=>JobLocations[rand(JobLocations.length)],:salary_id=>3,:avatar=>"406929_2668579486846_928068538_n.jpg")

Employee.create(:id => 2,:employee_id => 2, :title=> "Mr.", :first_name=>"bala",:last_name=>"nemani",:date_of_birth=>"2005-05-03", :gender=>"male", :marital_status=>"single", :total_experience=>"13",
:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-15-12",:date_of_join=>"2006-11-03",
 :image_url=> "image",
:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:designation_id=>Designations[rand(Designations.length)],
:grade_id=>Grades[rand(Grades.length)],:role_id=>Roles[rand(Roles.length)],:job_location_id=>JobLocations[rand(JobLocations.length)],
:permanent_address_id=>JobLocations[rand(JobLocations.length)],:present_address_id=>JobLocations[rand(JobLocations.length)],:salary_id=>3,:avatar=>"best-employee-md.png")

 
Employee.create(:id => 3,:employee_id => 3, :title=> "Miss.", :first_name=>"priyanka",:last_name=>"muddana",:date_of_birth=>"2005-05-03", :gender=>"female", :marital_status=>"single", :total_experience=>"1",
:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-15-12",:date_of_join=>"2006-11-03",
 :image_url=> "image",
:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:designation_id=>Designations[rand(Designations.length)],
:grade_id=>Grades[rand(Grades.length)],:role_id=>Roles[rand(Roles.length)],:job_location_id=>JobLocations[rand(JobLocations.length)],
:permanent_address_id=>JobLocations[rand(JobLocations.length)],:present_address_id=>JobLocations[rand(JobLocations.length)],:salary_id=>2,:avatar=>"gates_print.jpg")

Employee.create(:id => 4,:employee_id => 4, :title=> "Mrs.", :first_name=>"pinky",:last_name=>"kishore",:date_of_birth=>"2001-05-03", :gender=>"male", :marital_status=>"single", :total_experience=>"1",
:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-02-05",:date_of_join=>"2010-11-03",
 :image_url=> "image",
:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:designation_id=>Designations[rand(Designations.length)],
:grade_id=>Grades[rand(Grades.length)],:role_id=>Roles[rand(Roles.length)],:job_location_id=>JobLocations[rand(JobLocations.length)],
:permanent_address_id=>JobLocations[rand(JobLocations.length)],:present_address_id=>JobLocations[rand(JobLocations.length)],:salary_id=>1,:avatar=>"406929_2668579486846_928068538_n.jpg")



Education.create(:id=>1, :specilization=>"B.Tech", :institute=> "AU",:year_of_admission=> "2006-10-09", year_of_pass: "2010-06-08",:cgpa_percentage=> "78.50", :Employee_id=>1)
Education.create(:id=>5, :specilization=>"M.Tech", :institute=> "JNTU",:year_of_admission=> "2010-09-09", year_of_pass: "2012-05-04",:cgpa_percentage=> "81.20", :Employee_id=>1)

Education.create(:id=>2, :specilization=>"MBA", :institute => "GITAM",:year_of_admission=> "2006-10-09", year_of_pass: "2010-06-08",:cgpa_percentage=> "91.50", :Employee_id=>2)

Education.create(:id=>3, :specilization=>"MCA", :institute=> "AU",:year_of_admission=> "2006-10-09", year_of_pass: "2010-06-08",:cgpa_percentage=> "82.50", :Employee_id=>3)

Education.create(:id=>4, :specilization=>"M.Tech", :institute=> "AU",:year_of_admission=> "2006-10-09", year_of_pass: "2010-06-08",:cgpa_percentage=> "76.50", :Employee_id=>4)


Experience.create(:id=>1,:previous_company=>"Microsoft",:last_designation=>"Software Engineer",:from_date=>"2012-10-11",:to_date=>"2013-06-12",:employee_id=> 1)
Experience.create(:id=>2,:previous_company=>"TCS",:last_designation=>"Sr.Software Engineer",:from_date=>"2013-08-01",:to_date=>"2014-08-28",:employee_id=> 1)

Experience.create(:id=>3,:previous_company=>"Infosys",:last_designation=>"Software Engineer",:from_date=>"2012-10-11",:to_date=>"2013-06-12",:employee_id=> 2)

Experience.create(:id=>4,:previous_company=>"TCS",:last_designation=>"Java Developer",:from_date=>"2013-08-01",:to_date=>"2014-08-28",:employee_id=> 3)

Experience.create(:id=>5,:previous_company=>"Wipro",:last_designation=>".Net Developer",:from_date=>"2013-08-01",:to_date=>"2014-08-28",:employee_id=> 4)


Promotion.create(:id=>1,:date_of_promotion=>"2014-06-05", :employee_id=> 1, :designation_id=>1) 
Promotion.create(:id=>2,:date_of_promotion=>"2014-02-10", :employee_id=> 3, :designation_id=>2) 
Promotion.create(:id=>3,:date_of_promotion=>"2014-01-08", :employee_id=> 2, :designation_id=>1) 
Promotion.create(:id=>4,:date_of_promotion=>"2014-03-03", :employee_id=> 4, :designation_id=>3) 


EmailEttiquitie.create(:id=>1,:ettiquite=>"Need Holidays list for year 2014",:employee_id=>1,:dateofsending=>"2014-05-06") 
EmailEttiquitie.create(:id=>2,:ettiquite=>"Need Hand book/Scribbling pad",:employee_id=>1,:dateofsending=>"2014-08-06") 
EmailEttiquitie.create(:id=>3,:ettiquite=>"Need Holidays list for year 2014",:employee_id=>2,:dateofsending=>"2014-05-06") 
EmailEttiquitie.create(:id=>4,:ettiquite=>"Need Holidays list for year 2014",:employee_id=>3,:dateofsending=>"2014-05-06") 

Salary.create(:id=>1,:ctc_fixed=>"12000.00",:basic_salary=>"3500.00") 
Salary.create(:id=>2,:ctc_fixed=>"12000.00",:basic_salary=>"3500.00")
Salary.create(:id=>3,:ctc_fixed=>"12000.00",:basic_salary=>"3500.00")
Salary.create(:id=>4,:ctc_fixed=>"12000.00",:basic_salary=>"3500.00")

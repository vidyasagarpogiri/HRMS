# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# seeds for bloodgroup


#seeds for country


Country.delete_all
State.destroy_all
City.destroy_all
Address.destroy_all
JobLocation.destroy_all
Department.destroy_all
BloodGroup.destroy_all
FfStatus.destroy_all
Designation.destroy_all
Grade.destroy_all
Role.destroy_all
Employee.destroy_all

Country.create(:id=>1,:country_name=>"USA")
Country.create(:id=>2,:country_name=>"INDIA")
Country.create(:id=>3,:country_name=>"SINGAPORE")
Country.create(:id=>4,:country_name=>"AUSTRALIA")
countries = Country.all.pluck(:id)

State.create(:id=>1,:state_name => "Andhra",:country_id => countries[rand(countries.length)])
State.create(:id=>2,:state_name => "Alaska",:country_id => countries[rand(countries.length)])
State.create(:id=>3,:state_name => "Florida",:country_id => countries[rand(countries.length)])
State.create(:id=>4,:state_name => "Queens Land",:country_id => countries[rand(countries.length)]) 
states = State.all.pluck(:id)

City.create(:id=>1,:city_name => "Vizag",:state_id => states[rand(states.length)])
City.create(:id=>2,:city_name => "Starke",:state_id => states[rand(states.length)])
City.create(:id=>3,:city_name => "Hyd",:state_id => states[rand(states.length)])
City.create(:id=>4,:city_name => "Melbourne",:state_id => states[rand(states.length)])
cities = City.all.pluck(:id)

Address.create(:id=>1,:line1 => "BAY STREET",:line => "GUL END",:city_id => cities[rand(cities.length)])
Address.create(:id=>2,:line1 => "street 1",:line => "near KFC",:city_id => cities[rand(cities.length)])
Address.create(:id=>3,:line1 => "BEACH ROAD",:line => "OPP:IMAX THEATRE",:city_id => cities[rand(cities.length)])
Address.create(:id=>4,:line1 => "MARINE TOWERS",:line => "JURONG WEST",:city_id => cities[rand(cities.length)])
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
BloodGroup.create(:id=>2,:blood_group_name=>"B+ve") 
BloodGroup.create(:id=>3,:blood_group_name=>"A+ve") 
BloodGroup.create(:id=>4,:blood_group_name=>"AB+ve")
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
:permanent_address_id=>JobLocations[rand(JobLocations.length)],:present_address_id=>JobLocations[rand(JobLocations.length)])

Employee.create(:id => 2,:employee_id => 2, :title=> "Mr.", :first_name=>"bala",:last_name=>"nemani",:date_of_birth=>"2005-05-03", :gender=>"male", :marital_status=>"single", :total_experience=>"13",
:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-15-12",:date_of_join=>"2006-11-03",
 :image_url=> "image",
:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:designation_id=>Designations[rand(Designations.length)],
:grade_id=>Grades[rand(Grades.length)],:role_id=>Roles[rand(Roles.length)],:job_location_id=>JobLocations[rand(JobLocations.length)],
:permanent_address_id=>JobLocations[rand(JobLocations.length)],:present_address_id=>JobLocations[rand(JobLocations.length)])
 
Employee.create(:id => 3,:employee_id => 3, :title=> "Mrs.", :first_name=>"priyanka",:last_name=>"muddana",:date_of_birth=>"2005-05-03", :gender=>"female", :marital_status=>"single", :total_experience=>"1",
:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-15-12",:date_of_join=>"2006-11-03",
 :image_url=> "image",
:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:designation_id=>Designations[rand(Designations.length)],
:grade_id=>Grades[rand(Grades.length)],:role_id=>Roles[rand(Roles.length)],:job_location_id=>JobLocations[rand(JobLocations.length)],
:permanent_address_id=>JobLocations[rand(JobLocations.length)],:present_address_id=>JobLocations[rand(JobLocations.length)])

Employee.create(:id => 4,:employee_id => 4, :title=> "Mr.", :first_name=>"ravi",:last_name=>"kishore",:date_of_birth=>"2001-05-03", :gender=>"male", :marital_status=>"single", :total_experience=>"1",
:status=>"Active", :mobile_number=>"7894567485",:father_name=>"Father",:pan=>"pannumber", :date_of_confirmation=>"2006-02-05",:date_of_join=>"2010-11-03",
 :image_url=> "image",
:department_id =>Departments[rand(Departments.length)],:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)],:designation_id=>Designations[rand(Designations.length)],
:grade_id=>Grades[rand(Grades.length)],:role_id=>Roles[rand(Roles.length)],:job_location_id=>JobLocations[rand(JobLocations.length)],
:permanent_address_id=>JobLocations[rand(JobLocations.length)],:present_address_id=>JobLocations[rand(JobLocations.length)])

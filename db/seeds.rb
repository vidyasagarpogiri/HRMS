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

BloodGroup.destroy_all
FfStatus.destroy_all


Employee.destroy_all
#Education.destroy_all
#Experience.destroy_all
#Promotion.destroy_all
Salary.destroy_all
LeaveType.destroy_all
Group.destroy_all
Allowance.destroy_all
Event.destroy_all 
StaticSalary.destroy_all
Skill.destroy_all


 @user = User.invite!(:email =>  "vidyasagar.pogiri@amzur.com", :skip_invitation => true)
 Address.create(:line1 => "9-29-22,2nd Floor,Pioneer Sankar Shantiniketan", :line => "Balaji Nagar,Siripuram", :city => "Visakhapatnam", :state=>"Andhra Pradesh",:country=>"India",:zipcode=>"530003")
addresses = Address.all.pluck(:id)


(addresses).each do 
  JobLocation.create( :address_id => addresses[rand(addresses.length)])
end
JobLocations = JobLocation.all.pluck(:id)

# We are already created deparment and designations in Migration file
Departments = Department.all.pluck(:id)

Grades = Grade.all.pluck(:id)
#-----------------------------------------------------------------------------------------------------#

["O+ve", "O-ve", "A+ve", "A-ve", "B+ve", "B-ve", "AB+ve", "AB-ve"].each do |bloodgrp|
  BloodGroup.create(:blood_group_name => bloodgrp ) 
end
BloodGroups = BloodGroup.all.pluck(:id)

["Open", "Hold", "Closed"].each do |ffstatus|
  FfStatus.create(:status_name => ffstatus ) 
end
FfStatuses = FfStatus.all.pluck(:id)



["Hr Group", "Development", "Accounts"].each do |group|
  Group.create(:group_name => group)
end
Groups = Group.all.pluck(:id)

Department.find_by_department_name("HR").designations.create(designation_name: "HR ADMIN") 
dept_id = Department.find_by_department_name("HR").id
desg_id = Designation.find_by_designation_name("HR ADMIN").id
group_id = Group.find_by_group_name("Hr Group").id

Employee.create( :employee_id => 1, :title=>"Mr", :first_name=>"HR", :last_name=>"Admin", :date_of_birth=>"30/12/2001", :gender=>"male", :marital_status=>"single", :total_experience=>"6.5",
:status=>"Active", :mobile_number=>"9876543219",:father_name=>"Father",:pan=>"pan", :date_of_join=>"30/12/2001", :image_url=> "image",
:department_id => dept_id, :blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id => FfStatuses[rand(FfStatuses.length)], 
:job_location_id => JobLocations[rand(JobLocations.length)], :avatar => "406929_2668579486846_928068538_n.jpg", :user_id => @user.id, 
:alternate_email => "vankalabalaraju@gmail.com", :group_id => group_id, :designation_id => desg_id )







["Personal Leave", "Floating Holiday"].each do |leave|
LeaveType.create(:type_name => leave ) 
end
LeaveTypes = LeaveType.all.pluck(:id)




StaticSalary.create(:name => "Basic", :value => 40.0)
StaticSalary.create(:name => "PF", :value => 12)
StaticSalary.create(:name => "PF Contribution", :value => 13.61)
StaticSalary.create(:name => "Esic", :value => 1.75)
StaticSalary.create(:name => "Esic Contribution", :value => 4.25)
StaticSalary.create(:name => "HRA", :value => 25)


#Tax Brackets

TaxBracket.create(bracket: "Low Level", lower_limit: 0, upper_limit: 250000, tax_percentage: 0, min_tax: 0) 
TaxBracket.create(bracket: "Medium Level", lower_limit: 250001, upper_limit: 500000, tax_percentage: 10, min_tax: 0) 
TaxBracket.create(bracket: "High Level", lower_limit: 500001, upper_limit: 1000000, tax_percentage: 20, min_tax: 25000) 
TaxBracket.create(bracket: "Very High Level", lower_limit: 1000001, upper_limit: 12500000000, tax_percentage: 30, min_tax: 125000) 




['c','c++','ruby', 'rails','java','ios','android','asp.net','jquery','ajax','css','javascript','mysql','sqlite','oracle','pl/sql'].each do |skill|
  Skill.create(:name => skill ) 
end





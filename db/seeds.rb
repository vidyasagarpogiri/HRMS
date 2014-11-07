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
#Education.destroy_all
#Experience.destroy_all
#Promotion.destroy_all
Salary.destroy_all
LeaveType.destroy_all
#Group.destroy_all
Allowance.destroy_all
Event.destroy_all 
StaticSalary.destroy_all


#sekharberi@1989
 @user = User.invite!(:email =>  "vidyasagar.pogiri@amzur.com", :skip_invitation => true)
 #@user1 = User.invite!(:email =>  "balaraju.vankala@amzur.com", :skip_invitation => true)
 @user2 = User.invite!(:email =>  "priyanka.muddana@amzur.com", :skip_invitation => true)
 #@user3 = User.invite!(:email =>  "ramarao.pattabhi@amzur.com", :skip_invitation => true)





Address.create(:line1 => "BAY STREET",:line => "GUL END",:city => "Tampa",:state=>"New South Wales",:country=>"Australia",:zipcode=>"2000")
Address.create(:line1 => "street 1",:line => "near KFC",:city => "Vizag",:state=>"Andhra",:country=>"India",:zipcode=>"530003")
addresses = Address.all.pluck(:id)

(addresses).each do 
JobLocation.create( :address_id => addresses[rand(addresses.length)])
end
JobLocations = JobLocation.all.pluck(:id)

#-------------------------------------------------------------------------------------#
["Development", "HR", "Accounts", "Business Development"].each do |dept|
  Department.create(:department_name => dept ) 
end
Departments = Department.all.pluck(:id)

Department.all.each do |dept|
  
 
  ["Junior #{dept.department_name}", "Senior #{dept.department_name}"].each do |desg|
    designation = Designation.create(:designation_name => desg, :department_id => dept.id ) 
    
  
  end
  
end

Designations = Designation.all.pluck(:id)

Designation.all.each do |desg|
   ["Level1", "Level2", "Level3"].each do |level|
    Grade.create(:value => level, :designation_id =>  desg.id) 
  end
end
Grades = Grade.all.pluck(:id)
#-----------------------------------------------------------------------------------------------------#

["O+ve", "O-ve", "A+ve", "A+ve", "B+ve", "B-ve", "AB+ve", "AB-ve", "ABO (Bombay Blood Group)"].each do |bloodgrp|
BloodGroup.create(:blood_group_name => bloodgrp ) 
end
BloodGroups = BloodGroup.all.pluck(:id)

["Open", "Hold", "Closed"].each do |ffstatus|
FfStatus.create(:status_name => ffstatus ) 
end
FfStatuses = FfStatus.all.pluck(:id)



Employee.create(:employee_id => 1, :title=> "Mr", :first_name=>"Vidya Sagar ",:last_name=>"Pogiri",:date_of_birth=>"2014-12-30", :gender=>"male", :marital_status=>"single", :total_experience=>"6.5",:status=>"Active", :mobile_number=>"9876543219",:father_name=>"Father",:pan=>"pan", :date_of_confirmation=>"2013-05-09",:date_of_join=>"2014-03-03",:image_url=> "image",:department_id =>2,:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)], :job_location_id=>JobLocations[rand(JobLocations.length)],:avatar=>"406929_2668579486846_928068538_n.jpg", :user_id => @user.id, :alternate_email => "ravi.nuni@amzur.com", :devise_id => "85", :shift_id => "1")





Employee.create(:employee_id => 2, :title=> "Miss", :first_name=>"Priyanka",:last_name=>"Muddana",:date_of_birth=>"2014-12-18", :gender=>"female", :marital_status=>"single", :total_experience=>"6.5",:status=>"Active", :mobile_number=>"9876543219",:father_name=>"Father",:pan=>"QWERT1234A", :date_of_confirmation=>"2013-05-09",:date_of_join=>"2014-03-03",:image_url=> "image",:department_id =>2,:blood_group_id=> BloodGroups[rand(BloodGroups.length)],
:ff_status_id=>FfStatuses[rand(FfStatuses.length)], :job_location_id=>JobLocations[rand(JobLocations.length)],:avatar=>"406929_2668579486846_928068538_n.jpg", :user_id => @user2.id, :alternate_email => "ravi.nuni@amzur.com", :devise_id => "85", :shift_id => "1")








Employees = Employee.all.pluck(:id)


["Personal Leave", "Carry Forward Leave"].each do |leave|
LeaveType.create(:type_name => leave ) 
end
LeaveTypes = LeaveType.all.pluck(:id)


Event.create(:event_name =>"Pongal", :event_date => "14/01/2014")
Event.create(:event_name =>"Ugadi", :event_date => "11/04/2014")
Event.create(:event_name=>"Independence Day", :event_date => "15/08/2014")
Event.create(:event_name =>"Raksha Bhandan", :event_date => "23/08/2014")
Event.create(:event_name =>"Vinayaka Chaturthi", :event_date => "29/08/2014")
Event.create(:event_name =>"Dussehra", :event_date => "04/10/2014")
Event.create(:event_name =>"Diwali", :event_date => "14/11/2014")
Event.create(:event_name =>"Naga Panchami", :event_date => "21/11/2014")
Event.create(:event_name =>"Thanks Giving Day", :event_date => "27/11/2014")
Event.create(:event_name =>"Christmas", :event_date => "25/12/2014")

StaticSalary.create(:name => "Basic", :value => 40.0)
StaticSalary.create(:name => "PF", :value => 12)
StaticSalary.create(:name => "PF Contribution", :value => 13.61)
StaticSalary.create(:name => "Esic", :value => 1.75)
StaticSalary.create(:name => "Esic Contribution", :value => 4.25)



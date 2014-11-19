# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# seeds for bloodgroup


#seeds for country


BloodGroup.destroy_all
Department.destroy_all
Employee.destroy_all
LeaveType.destroy_all
Event.destroy_all
StaticSalary.destroy_all 


#sekharberi@1989
@user = User.invite!(:email =>  "sekhar.beri@amzur.com", :skip_invitation => true)
 






#-----------------------------------------------------------------------------------------------------#

["O+ve", "O-ve", "A+ve", "A+ve", "B+ve", "B-ve", "AB+ve", "AB-ve", "ABO (Bombay Blood Group)"].each do |bloodgrp|
BloodGroup.create(:blood_group_name => bloodgrp ) 
end
BloodGroups = BloodGroup.all.pluck(:id)

Department.create(:department_name => "HR")


Employee.create(:employee_id => 1, :title=> "Mr", :first_name=>"Sekhar",:last_name=>"Beri",:date_of_birth=>"2014-12-30", :gender=>"male",:mobile_number=>"9876543219",:father_name=>"Adinarayana",:date_of_join=>"2014-03-03",:image_url=> "image",:department_id =>1,:blood_group_id=> BloodGroups[rand(BloodGroups.length)],:avatar=>"406929_2668579486846_928068538_n.jpg", :user_id => @user.id, :alternate_email => "balaraju.vankala@gmail.com")

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
StaticSalary.create(:name => "HRA", :value => 25)


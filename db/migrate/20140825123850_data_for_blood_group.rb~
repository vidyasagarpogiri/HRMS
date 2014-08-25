class DataForBloodGroup < ActiveRecord::Migration
  def change
    puts "================================"
    puts "creating blood groups"
    BloodGroup.destroy_all
    BloodGroup.create(blood_group_name: "A+ve")
    BloodGroup.create(blood_group_name: "A-ve") 
    BloodGroup.create(blood_group_name: "B+ve")
    BloodGroup.create(blood_group_name: "B-ve")
    BloodGroup.create(blood_group_name: "O+ve")
    BloodGroup.create(blood_group_name: "O-ve")
    BloodGroup.create(blood_group_name: "AB+ve")
    BloodGroup.create(blood_group_name: "AB-ve")
    puts "==================================="
  end
end

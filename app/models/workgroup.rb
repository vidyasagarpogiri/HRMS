# This model belongs to workgroup # Author: Vidya Sagar Pogiri
class Workgroup < ActiveRecord::Base

  
   has_many :amzur_events, as: :eventable
   has_many :announcements, as: :announceable
   
   has_many :workgroups_employees # belongs to work group model
   has_many :employees, through: :workgroups_employees # belongs to work group model
   mount_uploader :workgroupicon # for workgroup image
   validates :name, presence: true
   validates :description, presence: true
   validates :admin_id, presence: true
   # to get admin name of workgroup
   def admin_name

    Employee.find(admin_id).full_name
  end
end

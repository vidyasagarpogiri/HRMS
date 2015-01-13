class Announcement < ActiveRecord::Base
  belongs_to :announceable, polymorphic: true
  include Bootsy::Container
  validates :title, presence: true
  #validates :description, presence: true
  
  def self.get_eventable(event)
  #raise event.inspect
	case event.announceable_type
     when "Department"
     #raise eventable_type.inspect
     announceable = event.announceable_type.classify.constantize.find(event.announceable_id).department_name 
     #raise eventable.inspect
     when "Group"
     announceable = event.announceable_type.classify.constantize.find(event.announceable_id).group_name
     
     when "Workgroup"
    announceable = event.announceable_type.classify.constantize.find(event.announceable_id).name
    end
    return announceable
	end
	
  def self.all_announcements(employee)
    admin_work_group_announcements =  Workgroup.where(admin_id: employee.id).map(&:announcements)
    workgroup_announcements = employee.workgroups.map(&:announcements)
    company_announcements = Announcement.where(announceable_type: nil)
    department_announcements = employee.department.announcements if employee.department.present?
    group_announcements = employee.group.announcements if employee.group.present?
    total_announcements = [ admin_work_group_announcements ,  workgroup_announcements,  company_announcements, department_announcements,  group_announcements].flatten.uniq
    current_announcements = []
    total_announcements.each do |d|
      if (d.updated_at.to_date - Date.today).to_i < 30
        current_announcements << d  
      end
    end
    current_announcements
  end
  
end

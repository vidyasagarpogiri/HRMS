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
    admin_work_group_events =  Workgroup.where(admin_id: employee.id).map(&:amzur_events)
    workgroup_events = employee.workgroups.map(&:amzur_events)
    company_events = AmzurEvent.where(eventable_type: nil)
    department_events = employee.department.amzur_events if employee.department.present?
    group_events = employee.group.amzur_events if employee.group.present?
    total_events = [ employee.amzur_events, department_events,  group_events, admin_work_group_events, workgroup_events, company_events].flatten.uniq
    current_events = []
    total_events.each do |d|
       if d.held_on.to_date >= Date.today
          current_events << d
        end
    end
    current_events
  end
  
end

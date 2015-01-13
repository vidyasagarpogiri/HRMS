class AmzurEvent < ActiveRecord::Base
  belongs_to :employee
  belongs_to :eventable, polymorphic: true  
  
  include Bootsy::Container
  validates :title, presence: true
	#validates :description, presence: true
	validates :held_on, presence: true
	#validates  :from_time, presence: true
	#validates :to_time, presence: true
	
	def self.get_eventable(event)

	case event.eventable_type
     when "Department"
     #raise eventable_type.inspect
     eventable = event.eventable_type.classify.constantize.find(event.eventable_id).department_name 
     #raise eventable.inspect
     when "Group"
     eventable = event.eventable_type.classify.constantize.find(event.eventable_id).group_name
     
     when "Workgroup"
    eventable = event.eventable_type.classify.constantize.find(event.eventable_id).name
    end
   eventable
	end

  def self.all_events(employee)
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
	


  def self.get_amzur_events
    a = []
    AmzurEvent.all.each do |d|
       if d.held_on.to_date >= Date.today
          a << d
        end
   
   end
     a
 
end
end

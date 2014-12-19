class AmzurEvent < ActiveRecord::Base
  belongs_to :employee
  belongs_to :eventable, polymorphic: true  
  
  include Bootsy::Container
  validates :title, presence: true
	#validates :description, presence: true
	#validates :held_on, presence: true
	
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
    return eventable
	end
	
end



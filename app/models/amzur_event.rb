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

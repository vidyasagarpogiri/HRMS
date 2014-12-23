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
	
  
  
end

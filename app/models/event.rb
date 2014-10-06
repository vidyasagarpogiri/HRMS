class Event < ActiveRecord::Base
 

  has_many :holiday_calenders
  has_many :departments, :through => :holiday_calenders


  validates :event_name, uniqueness: { case_sensitive: false }
  validates :event_date, uniqueness: true
end

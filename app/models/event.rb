class Event < ActiveRecord::Base
has_many :holiday_calenders
has_many :groups, :through => :holiday_calenders
end

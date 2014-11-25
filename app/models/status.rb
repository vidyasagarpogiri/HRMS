class Status < ActiveRecord::Base
  belongs_to :employee  # status belongs to employee
  has_many :comments  # status may have more than one comment so has_many relaionship
  has_many :likes #one status may have more than one like
end

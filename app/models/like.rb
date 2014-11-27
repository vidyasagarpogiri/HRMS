class Like < ActiveRecord::Base
  belongs_to :employee
  belongs_to :status
  validates :employee_id, presence: true 
  validates :is_like, :inclusion => {:in => [true, false]} 
  validates :status_id, presence: true   
  
  
end

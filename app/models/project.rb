class Project < ActiveRecord::Base
  belongs_to :employee
  
  
  validates :employee_id, presence: true
  validates :title, presence: true
end

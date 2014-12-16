class Project < ActiveRecord::Base
  belongs_to :employee
  
  validates :start_date, presence: true
  validates :employee_id, presence: true
  validates :title, presence: true
end

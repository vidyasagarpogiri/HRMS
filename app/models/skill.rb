class Skill < ActiveRecord::Base

  has_many :employee_skills
  has_many :employees, :through => :employee_skills
end

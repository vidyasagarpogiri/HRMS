# This model belongs to workgroupemployee # Author: Vidya Sagar Pogiri
class WorkgroupsEmployee < ActiveRecord::Base
  belongs_to :workgroup # belongs to work group model
  belongs_to :employee #belongs to employee model
end

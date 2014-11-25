class Like < ActiveRecord::Base
  belongs_to :employee
  belongs_to :status
end

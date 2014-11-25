class Comment < ActiveRecord::Base
  belongs_to :status
  belongs_to :employee
  default_scope {order('created_at DESC')}
end

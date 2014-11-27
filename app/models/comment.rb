class Comment < ActiveRecord::Base
  belongs_to :status
  belongs_to :employee
  default_scope {order('created_at DESC')} 
  validates :comment, presence: true
  validates :employee_id, presence: true 
  validates :status_id, presence: true
  #scope :recent, order('created_at desc').limit(10)
   #Comment.order("updated_at desc").limit(10)
end

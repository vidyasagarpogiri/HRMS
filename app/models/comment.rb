class Comment < ActiveRecord::Base
  belongs_to :status
  belongs_to :employee
  default_scope {order('created_at DESC')} 
  #scope :recent, order('created_at desc').limit(10)
   #Comment.order("updated_at desc").limit(10)
end

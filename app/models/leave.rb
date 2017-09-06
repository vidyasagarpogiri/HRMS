class Leave < ActiveRecord::Base   
                         
  belongs_to :employee                                                                       
                                                                       
  validates :pl_carry_forward_prev_year, presence: true 
  validates :pl_applied, presence: true
  validates :sl_applied, presence: true
  validates :employee_id, presence: true
                 
end          
                          
           
              
       

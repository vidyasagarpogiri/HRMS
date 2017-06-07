class Group < ActiveRecord::Base
                 
  has_many :employees                                                                                                          
  has_one :leave_policy                                                                                                                                    
  has_many :holiday_calenders                                         
  has_many :events, :through => :holiday_calenders
  has_one :reporting_manager
                                                                                                                                      
  def reporting_manager_full_name                 
    reporting_manager.employee.full_name if reporting_manager.present?
  end               
        
end   

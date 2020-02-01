class LeaveHistoriesController < ApplicationController      
	                                                  
  #before_filter :hr_view,  only: ["new", "edit"]                                                                                  
  #before_filter :other_emp_view                                                                                                                                                                                                      
	                                                                                                                                                                                                                                                              
  layout "leave_template"                                                                                                                                                                                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
 include ApplicationHelper                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                         
def index                                                                                                                                                                                                                                                                                    
  @leave =current_user.employee.department.leave_policy                                                                                                                                                       
  @leaves = current_user.employee.leave_histories.where(:status => 'HOLD').page(params[:page]).per(4)
  @leave_histories = current_user.employee.leave_histories.where("status != ?", "HOLD" ).page(params[:page]).per(4)
  @employee = current_user.employee                    
end                                                     
                                                     
  def new                          
   @employee = current_user.employee
   @leave_history = LeaveHistory.new               
  end                             
                                          
  def show                                            
  #raise params.inspect                                                                   
  end                      
                                    
  def create                                               
    #raise params.inspect                                 
    @employee = current_user.employee                                      
    @leave_history = current_user.employee.leave_histories.new(params_leave_history)
    total_days = (@leave_history.to_date.to_date - @leave_history.from_date.to_date).to_i + 1
    weekend_count = weekends(@leave_history.to_date.to_date,  @leave_history.from_date.to_date)  
    applied_days = total_days - weekend_count               
    #--TODO----- leave balance alert before save                                                                                                                                                  
    @leave_history.save                                                                                                                                                                    
    @leave_history.update(:days => applied_days)                                                                                                                                                                                                                                                                                                                                                                                                                                                                              
                                                                                                                             
  end                                                                                                                                                                                                                 
end                                                                                                                                                                                                                                             
                                                                                                         

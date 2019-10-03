class LeavePoliciesController < ApplicationController                            
	                                                    
  before_filter :hr_view,  only: ["new", "edit"]                                                
  before_filter :other_emp_view                                                                                                                                                         
  layout "leave_template"                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                      
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                          
 def index                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
   @department = Department.find(params[:department_id])                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                   
   @leave_policy = @department.leave_policy                                                                                                                                                                                                                                                                                                                                                                                                                                                                                  
 end                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
 def new                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
  @department = Department.find(params[:department_id])                                                                                                                                                                                                                                                                                                                                                                                                               
  @leave_policy = LeavePolicy.new                                                                                                                                                                                                                                  
 end                                                                                                                     
                    
 def create               
   @department = Department.find(params[:department_id])
   @leave_policy = LeavePolicy.create(params_leavepolicy)      
   @leave_policy.department_id = params[:department_id]                                      
   @leave_policy.save
   redirect_to leaves_department_path(@department)         
 end                 
	    
                     
 def edit                                 
 @department = Department.find(params[:department_id])
  @leave_policy = @department.leave_policy
 end                                                                       
                       
 def update                                   
  @department = Department.find(params[:department_id])                                  
  @leave_policy = @department.leave_policy                                                                                                                                                                   
  @leave_policy.update(params_leavepolicy)                                                                                                                                                                                       
  redirect_to leaves_department_path(@department)                                                                                                                                                                                                                                                       
 end                                                                                                                                                                                                              
                                                                                                                                                                                                                                                                                                                                                                                                                                           
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                     
 def params_leavepolicy                                                                                                                                                                                                                                                       
    params.require(:leave_policy).permit(:pl_this_year, :sl_this_year, :eligible_carry_forward_leaves)
  end
                    
end              

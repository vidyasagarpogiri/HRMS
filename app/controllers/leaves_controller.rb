 class LeavesController<Controller                            
                   
 before_filter :hr_view,  only: ["new", "edit"]
 before_filter :other_emp_view                         
                                                                                                                                                                               
 layout "leave_template"                                                                                                                                                                                                                                                                                                                                                                                                                                                               
                                                                                                                                                                                                                                                                                                                                                                                                 
 def index                                                                                                                                                                                                                                                                                                                                                                        
  @leaves = Leave.all                                                                                                                                                                                                                                               
  @employee = Employee.find(params[:employee_id])                                                                                                                                                                                                
 end                                                                                                                                                       
        params_insentive             
 def new    
  @leave = Leave.new               
  @employee = Employee.find(params[:employee_id])                         
 end    
            
 def create                     
   @employee = Employee.find(params[:employee_id])
   @leave = Leave.create(params_leaves)
   redirect_to employee_leaves_path
 end                                                   
                                                     
 def params_leaves
    params.require(:leave).permit(:pl_carry_forward_prev_year, :pl_applied, :sl_applied, :lop_applied)
  end
                                                                            
end   
                                
                     
                       
                                        
                       
   

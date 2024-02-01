class DepartmentsController< Controller       
	
 layout "leave_template", only: [:leaves, :index, :employee_leaves, :holiday_list]
                   
  def index
    @departments = Department.all                                 
  end                                                                                    
                                                     
  def new      
    @department = Department.new                                                        
  end                                       
 
  def create
    @department = Department.create(department_params)
    redirect_to @department
  end   
                                                               
  def show                                               
    @department = Department.find(params[:id])
    @employees = @department.employees
    @leave_policy = @department.leave_policy                
    @holiday_calender = @department.events             
    @designations = @department.designations                 
  end                                                                       
                                                                      
  def update
    @department = Department.find(params[:id])              
    @department.update(department_params)
    redirect_to @department
  end
  
  def edit     
    @department = Department.find(params[:id])        
  end
                                               
  def destroy                                                
    @department = Department.find(params[:id])
    @department.destroy                                                                                          
    redirect_to @department                                                                                                                                                                                                       
  end                                                  
	
  def add_employee
    @department = Department.find(params[:id])
    @employee = Employee.all
  end
     
   def update_employee
    @department = Department.find(params[:id])
    @employee = Employee.find(params[:employee_id])
    @employee.update(:department_id => @department.id)
    redirect_to @department
   end   
   
   def leaves
    # raise params.inspect
    @department = Department.find(params[:id])
    @employees = @department.employees
    @leave_policy = @department.leave_policy
    @holiday_calenders = @department.holiday_calenders
   end
	
   def department_index
     @departments = Department.all
   end
   
  def employee_leaves
    @dept = Department.find(params[:id])
    @employees = @dept.employees
    # raise @employees.inspect
    @leaves = @employees.order("created_at DESC").map(&:leave_histories).flatten if @employees.present?
    # raise @leaves.flatten.inspect
    # flatten makes array of arrys into a single array
    # Here @leaves object is depatrment all Employee leaves of array tpye pasrse it in employee_leaves view page..BY:GPR###
    # raise @leaves[1][1]['employee_id'].inspect
  end  
        
  def holiday_list
    @holidays = current_user.employee.department.holiday_calenders
    # raise @holiday.inspect
    @leave_policy = current_user.employee.department.leave_policy
    @department = current_user.employee.department
 end
  

  private
  def department_params
    params.require(:department).permit(:department_name) 
  end    
	
end              

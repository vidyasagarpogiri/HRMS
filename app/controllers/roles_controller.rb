  class RolesController<Controller                                                                                                                        
	                                                                                                     
  before_filter :hr_view,  only: ["new", "edit"]                                                                                 
  before_filter :other_emp_view                                                                                                                                                                                                                                                         
	                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                        
  def index                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                           
    @roles = Role.all                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    						                                                                                                                                                                                                                                                                                                                                                      
  end                                                                                                                                                                                                                                                                                                                                                                                                                                                             
                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
  def new                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                            
    @role = Role.new                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                             
  end                                                                                                                                                                                                                                                                                                                                
                                                                                                                                                                                                         
  def create                                                                                           
	  @role = Role.create(role_params)                   
    redirect_to @role                        
  end           
                             
  def show           
    @role = Role.find(params[:id])
    @employees = @role.employees               
  end    
                                              
  def update   
    @role = Role.find(params[:id])                                               
    @role.update(role_params)
    redirect_to @role                       
  end       
	         
	  
  def edit                                                    
    @role = Role.find(params[:id])                                                    
  end                                                                        
                                                  
  def destroy                                                                                                                                                                                                                                     
    @role = Role.find(params[:id])                                                                                                                                                                                                                                                        
    @role.destroy                                                                                                                                                                                                                                                                                                                                                                      
  end                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 
	                                                                                                                                                                                                                                                                                                                                                                                    
   def add_employee               
    @role = Role.find(params[:id])                             
    @employee = Employee.all
  end
  
   def update_employee
    @role = Role.find(params[:id])
    @employee = Employee.find(params[:employee_id])
    @employee.update(:role_id => @role.id)
    redirect_to @role
   end 
  
	
  private
  def role_params
    params.require(:role).permit(:role_name) 
  end
  
end  
            
